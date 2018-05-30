import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import './../models/weather_state.dart';
import './../constants/constants.dart' as constants;

class WeatherDao {
  static final http.Client _httpClient = http.Client();
  static final String _weatherUrl =
      '${constants.weatherAPI}?q={1}&appId=${constants.weatherAppId}&units=metric';

  static Future<WeatherState> getClimateSummary(String city) async {
    return _httpClient
        .get(Uri.parse(_weatherUrl.replaceFirst('{1}', city)))
        .then((res) => res.body)
        .then(json.decode)
        .then((data) => WeatherState(
            city: city,
            temperature: data['main']['temp'].toDouble(),
            temperatureMin: data['main']['temp_min'].toDouble(),
            temperatureMax: data['main']['temp_max'].toDouble(),
            humidity: data['main']['humidity'].toDouble()))
        .catchError((error) => WeatherState.error());
  }
}
