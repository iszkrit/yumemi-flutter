import 'package:flutter/material.dart';
import 'package:flutter_training/first_page.dart';
import 'package:flutter_training/weather_controller.dart';
import 'package:flutter_training/weather_page.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final YumemiWeather yumemiWeather = YumemiWeather();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/weather': (context) => WeatherPage(
              weatherController: WeatherController(),
            ),
      },
    );
  }
}
