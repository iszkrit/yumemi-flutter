import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

enum WeatherType {
  sunny,
  cloudy,
  rainy,
  none
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.weatherType});
  final WeatherType weatherType;

  @override
  Widget build(BuildContext context) {
    late Widget weatherIcon;

    switch (weatherType) {
      case WeatherType.sunny:
        weatherIcon = SvgPicture.asset(Assets.images.sunny);
      case WeatherType.cloudy:
        weatherIcon = SvgPicture.asset(Assets.images.cloudy);
      case WeatherType.rainy:
        weatherIcon = SvgPicture.asset(Assets.images.rainy);
      case WeatherType.none:
        weatherIcon = const Placeholder();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: weatherIcon,
    );
  }
}

class _TemperatureLabels extends StatelessWidget {
  const _TemperatureLabels();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '** ℃',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '** ℃',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherContainer extends StatelessWidget {
  const _WeatherContainer({
    required this.weatherType,
  });
  final WeatherType weatherType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WeatherIcon(weatherType: weatherType),
        const _TemperatureLabels(),
      ],
    );
  }
}

class _CommandButtons extends StatelessWidget {
  const _CommandButtons({required this.reloadWeather});
  final VoidCallback reloadWeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Close',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: reloadWeather,
            child: Text(
              'Reload',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  YumemiWeather yumemiWeather = YumemiWeather();
  late WeatherType weatherType;

  void _fetchWeather() {
    try {
      final weatherData = yumemiWeather.fetchSimpleWeather();

      setState(() {
        switch (weatherData) {
          case 'sunny':
            weatherType = WeatherType.sunny;
          case 'cloudy':
            weatherType = WeatherType.cloudy;
          case 'rainy':
            weatherType = WeatherType.rainy;
          default:
            weatherType = WeatherType.none;
            break;
        }
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(
              children: [
                const Spacer(),
                _WeatherContainer(
                  weatherType: weatherType,
                ),
                Flexible(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      _CommandButtons(
                        reloadWeather: _fetchWeather,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
