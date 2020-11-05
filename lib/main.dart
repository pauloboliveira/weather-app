import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_page.dart';

// Gerado automaticamente
void main() {
  runApp(CityWeather());
}

String nomeApp = "Previsão do Tempo";
var mainColor = Colors.blue;

// Classe principal
class CityWeather extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: nomeApp,
      home: CityWeatherPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class _CityInputText extends State<CityInputText> {
//   // chave de API disponibilizada por OpenWeatherMap
//   final String apiKey = '54b0b79aea00c5f7a8372502556a3962';
//   // unidade de medida: metric (celsius) ou imperial (fahrenheit)
//   final String units = 'metric';

//   String _city = '';
//   String _temp, _feelsLike, _tempMin, _tempMax, _humidity;
//   var _isVisible = false;

//   void dispose() {
//     widget.cityController.dispose();
//     super.dispose();
//   }

//   String roundValue(dynamic value) {
//     if (value is double) {
//       return value.round().toString();
//     } else if (value is int) {
//       return value.round().toString();
//     }
//     return value.toString();
//   }

//   void updateCity(String city, dynamic json, String country) {
//     setState(() {
//       _city = city + ", " + country;
//       updateVisibility(_city.length > 0);

//       _temp = roundValue(json["temp"]);
//       _feelsLike = roundValue(json["feels_like"]);
//       _tempMin = roundValue(json["temp_min"]);
//       _tempMax = roundValue(json["temp_max"]);
//       _humidity = roundValue(json["humidity"]);
//     });
//   }

//   void updateVisibility(bool isVisible) {
//     setState(() {
//       _isVisible = isVisible;
//     });
//   }

//   // realiza fetch na API
//   void btnSendCity() async {
//     // TRIM apaga os espaços no começo e no final de uma String
//     var city = widget.cityController.text.trim();
//     var uri = "http://api.openweathermap.org/data/2.5/weather?q=" +
//         city.replaceAll(' ', '+') +
//         "&appid=" +
//         apiKey +
//         "&units=" +
//         units;

//     // Exibir no console a URI
//     // print(uri);

//     var response = await http.get(uri);
//     if (response.statusCode != 200) {
//       updateVisibility(false);
//       return;
//     }

//     var body = jsonDecode(response.body);
//     var main = body['main'];
//     var country = body["sys"]["country"];
//     updateCity(body["name"], main, country);
//   }

//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                     child: TextFormField(
//                   controller: widget.cityController,
//                   decoration: InputDecoration(
//                     hintText: 'Informe o nome da cidade',
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.send),
//                       onPressed: btnSendCity,
//                       color: mainColor,
//                     ),
//                   ),
//                 )),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 32),
//                         child: Visibility(
//                             visible: _isVisible,
//                             child: Center(
//                               child: Text("$_city",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 24,
//                                       color: mainColor)),
//                             ))))
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 16),
//                         child: Visibility(
//                           visible: _isVisible,
//                           child: Center(child: Text("Min: $_tempMin ºC")),
//                         ))),
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 16),
//                         child: Visibility(
//                           visible: _isVisible,
//                           child: Center(child: Text("Max: $_tempMax ºC")),
//                         ))),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 16),
//                         child: Visibility(
//                           visible: _isVisible,
//                           child: Text("Temperatura: $_temp ºC"),
//                         ))),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 16),
//                         child: Visibility(
//                           visible: _isVisible,
//                           child: Text("Sensação térmica: $_feelsLike ºC"),
//                         ))),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 16),
//                         child: Visibility(
//                           visible: _isVisible,
//                           child: Text("Umidade do ar: $_humidity%"),
//                         ))),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                         padding: EdgeInsets.only(top: 16),
//                         child: Visibility(
//                           visible: !_isVisible,
//                           child: Center(
//                               child: Text(
//                             "Nome de cidade inválido!",
//                             style: TextStyle(color: Colors.red, fontSize: 25),
//                           )),
//                         ))),
//               ],
//             ),
//           ],
//         ));
//   }
// }
