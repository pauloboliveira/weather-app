import 'dart:ffi';

import 'package:weather_app/domain/weather.dart';

class Data {
  Weather weather;
  double maxTemp;
  String datetime;
  String temp;
  double minTemp;

  Data({
    this.weather,
    this.maxTemp,
    this.datetime,
    this.temp,
    this.minTemp,
  });

  Data.fromJson(Map<String, dynamic> json) {
    weather =
        json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    maxTemp = double.parse(json['max_temp'].toString());
    datetime = json['datetime'].toString();
    temp = json['temp'].toString();
    minTemp =  double.parse(json['min_temp'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
    data['max_temp'] = this.maxTemp;
    data['datetime'] = this.datetime;
    data['temp'] = this.temp;
    data['min_temp'] = this.minTemp;

    return data;
  }
}
