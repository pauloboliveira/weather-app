import 'package:weather_app/domain/data.dart';

class WeatherData {
  List<Data> data;
  String cityName;
  String lon;
  String timezone;
  String lat;
  String countryCode;
  String stateCode;

  WeatherData(
      {this.data,
      this.cityName,
      this.lon,
      this.timezone,
      this.lat,
      this.countryCode,
      this.stateCode});

  WeatherData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    cityName = json['city_name'];
    lon = json['lon'];
    timezone = json['timezone'];
    lat = json['lat'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['city_name'] = this.cityName;
    data['lon'] = this.lon;
    data['timezone'] = this.timezone;
    data['lat'] = this.lat;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    return data;
  }
}
