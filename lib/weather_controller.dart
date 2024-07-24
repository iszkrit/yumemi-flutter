import 'dart:convert';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';
import 'package:flutter_training/model/weather_data.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherInfo {
  final SvgPicture? icon;
  final int? maxTemperature;
  final int? minTemperature;

  WeatherInfo(
      {required this.icon,
      required this.maxTemperature,
      required this.minTemperature});
}

class WeatherController {
  final yumemiWeather = YumemiWeather();
  static const jsonString = '''
    {
        "area": "tokyo",
        "date": "2020-04-01T12:00:00+09:00"
    }
  ''';
  WeatherInfo? getWeatherInfo() {
    final weatherJson = yumemiWeather.fetchWeather(jsonString);
    final weatherDecode = jsonDecode(weatherJson) as Map<String, dynamic>;
    final weatherData = WeatherData.fromJson(weatherDecode);

    final icon = Weather.fromName(weatherData.weatherCondition).icon;
    final maxTemperature = weatherData.maxTemperature;
    final minTemperature = weatherData.minTemperature;

    return WeatherInfo(
        icon: icon,
        maxTemperature: maxTemperature,
        minTemperature: minTemperature);
  }
}

enum Weather {
  sunny,
  cloudy,
  rainy,
  unknown;

  factory Weather.fromName(String name) {
    switch (name) {
      case 'sunny':
        return Weather.sunny;
      case 'cloudy':
        return Weather.cloudy;
      case 'rainy':
        return Weather.rainy;
    }
    return Weather.unknown;
  }
}

extension WeatherExtensions on Weather {
  SvgPicture? get icon {
    switch (this) {
      case Weather.sunny:
        return Assets.images.sunny.svg();
      case Weather.cloudy:
        return Assets.images.cloudy.svg();
      case Weather.rainy:
        return Assets.images.rainy.svg();
      case Weather.unknown:
        return null;
    }
  }
}
