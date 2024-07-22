import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

enum WeatherType { sunny, cloudy, rainy, none }

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon(this._weatherType);
  final WeatherType _weatherType;

  @override
  Widget build(BuildContext context) {
    late Widget weatherIcon;

    switch (_weatherType) {
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
  const _WeatherContainer(this._weatherType);
  final WeatherType _weatherType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WeatherIcon(_weatherType),
        const _TemperatureLabels(),
      ],
    );
  }
}

class _CommandButtons extends StatelessWidget {
  const _CommandButtons(this._close, this._reload);
  final VoidCallback _close;
  final VoidCallback _reload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _close,
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
            onPressed: _reload,
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

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({required this.yumemiWeather, super.key});
  final YumemiWeather yumemiWeather;

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();

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

class _WeatherWidgetState extends State<WeatherWidget> {
  late WeatherType weatherType = WeatherType.none;

  void _fetchWeather() {
    try {
      final weatherData = widget.yumemiWeather.fetchSimpleWeather();

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
      setState(() {
        weatherType = WeatherType.none;
      });
    }
  }

  Future<void> _close() async {
    await Navigator.pushNamed(context, '/');
  }

  void _reload() {
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              _WeatherContainer(weatherType),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    _CommandButtons(
                      _close,
                      _reload,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<WeatherType>('weatherType', weatherType));
  }
}
