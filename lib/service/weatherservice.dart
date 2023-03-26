import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/weathermodel.dart';

class WeatherRepo {
  Future fetchWeather(location) async {
    try {
      // Uri url = Uri.parse(
      //     "https://api.openweathermap.org/data/2.5/weather?q=London&appid=589b81f8a23f942ece84e1738d91ca74&units=metric");
      Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=589b81f8a23f942ece84e1738d91ca74&units=metric");
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return weatherModelFromJson(response.body);
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
