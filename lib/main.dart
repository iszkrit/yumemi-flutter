import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/entry_widget.dart';
import 'package:flutter_training/weather_widget.dart';
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
        '/': (context) => const EntryWidget(),
        '/weather': (context) => WeatherWidget(yumemiWeather: yumemiWeather),
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<YumemiWeather>(
        'yumemiWeather',
        yumemiWeather,
      ),
    );
  }
}
