import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/domain/data.dart';

import 'domain/weather_data.dart';

class CityWeatherPage extends StatefulWidget {
  _CityWeatherPageState createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  TextEditingController cityController = TextEditingController();

  final String apiKey = '54b0b79aea00c5f7a8372502556a3962';
  final String apikey2 = '6a9a9481722d47e088000f6cf909c7a2';
  final String units = 'metric';

  String _city = '';
  String _temp, _feelsLike, _tempMin, _tempMax, _humidity;

  var _lon, _lat;
  var _isVisible = false, _url;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  var auto = WeatherData();

  StreamController _streamController = BehaviorSubject();

  initState() {
    super.initState();
    getterForecast("Indaiatuba", "BR");
    btnSendCity("Indaiatuba");
  }

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  String roundValue(dynamic value) {
    if (value is double) {
      return value.round().toString();
    } else if (value is int) {
      return value.round().toString();
    }
    return value.toString();
  }

  void getterForecast(String city, String country) async {
    var url = "https://api.weatherbit.io/v2.0/forecast/daily?city=" +
        city +
        "&country=" +
        country +
        "&key=" +
        apikey2 +
        "&units=" +
        units +
        "&days=5";
    print(url);
    var response = await http.get(url);
    if (response.statusCode != 200) {
      updateVisibility(false);
      return;
    }
    var model = json.decode(response.body);
    auto = WeatherData.fromJson(model);
    _streamController.add(auto);
    print(auto.data);
  }

  void updateCity(String city, dynamic json, String country) {
    setState(() {
      _city = city + ", " + country;
      updateVisibility(_city.length > 0);

      _temp = roundValue(json["temp"]);
      _feelsLike = roundValue(json["feels_like"]);
      _tempMin = roundValue(json["temp_min"]);
      _tempMax = roundValue(json["temp_max"]);
      _humidity = roundValue(json["humidity"]);
    });
  }

  void updateVisibility(bool isVisible) {
    setState(() {
      _isVisible = isVisible;
    });
  }

  // realiza fetch na API
  void btnSendCity(String city) async {
    // TRIM apaga os espaços no começo e no final de uma String
    //var city = cityController.text.trim();
    var uri = "http://api.openweathermap.org/data/2.5/weather?q=" +
        city.replaceAll(' ', '+') +
        "&appid=" +
        apiKey +
        "&units=" +
        units;

    // Exibir no console a URI/
    print(uri);
    var response = await http.get(uri);
    if (response.statusCode != 200) {
      updateVisibility(false);
      return;
    }

    var body = jsonDecode(response.body);
    var main = body['main'];
    var country = body["sys"]["country"];
    updateCity(body["name"], main, country);
    getterForecast(city, country);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(53, 71, 182, 300),
        child: Column(
          children: [
            _day(),
            Divider(
              color: Color.fromRGBO(182, 193, 215, 300),
              endIndent: 15,
              indent: 15,
              thickness: 0.8,
              height: 0.1,
            ),
            _scrollNextDays(),
            Container(
              height: 70,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: cityController,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      //size: 20,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _city = cityController.text.trim();
                        btnSendCity(_city);
                      }),
                  hintText: 'Pesquise uma cidade',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scrollNextDays() {
    return StreamBuilder<Object>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            );
          }

          return Container(
            height: 300,
            padding: EdgeInsets.all(16),
            child: ListView.separated(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DateFormat formatDate = new DateFormat("yyyy-MM-dd HH:mm:ss");

                DateFormat formatDateBrazil = new DateFormat("dd/MM/yyyy");

                DateTime date =
                    formatDate.parse(auto.data[index].datetime + " 00:00:00");

                String data = formatDateBrazil.format(date);

                Data weatherData = auto.data[index];

                double temp = double.parse(weatherData.temp);

                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(182, 193, 215, 300),
                      border: Border.all(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: 250,
                  height: 250,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data,
                              style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 50),
                            Text(
                              ('${weatherData.temp.toString()} º'),
                              style: GoogleFonts.notoSans(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              temp > 25
                                  ? Icons.wb_sunny
                                  : Icons.wb_cloudy_rounded,
                              color: temp > 25 ? Colors.yellow : Colors.white,
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        endIndent: 10,
                        indent: 10,
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  (weatherData.maxTemp.toString()),
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'max',
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
                                  size: 12,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  (weatherData.minTemp.toString()),
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'min',
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.blue[700],
                                  size: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return VerticalDivider();
              },
            ),
          );
        });
  }

  _day() {
    double temp;
    if (_temp != null) {
      temp = double.parse(_temp);
    }

    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$_city',
                    style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        ' $_tempºC',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        temp > 25 ? Icons.wb_sunny : Icons.wb_cloudy_rounded,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 30,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Sensação',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$_feelsLikeºC',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Color.fromRGBO(182, 193, 215, 300),
            endIndent: 25,
            indent: 25,
            thickness: 0.8,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        '$_tempMaxºC',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'max',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_upward,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 17,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '$_tempMinºC',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'min',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_downward,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 17,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '$_humidity%',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'umi',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.cloud_queue,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 17,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
