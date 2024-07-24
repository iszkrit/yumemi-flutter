import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/error_dialog.dart';
import 'package:flutter_training/weather_controller.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class _TemperatureLabels extends StatelessWidget {
  const _TemperatureLabels({int? maxTemperature, int? minTemperature})
      : _maxTemperature = maxTemperature,
        _minTemperature = minTemperature;
  final int? _maxTemperature;
  final int? _minTemperature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${_minTemperature ?? '**'} ℃',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.blue,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              '${_maxTemperature ?? '**'} ℃',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
    SvgPicture? weatherIcon,
    int? maxTemperature,
    int? minTemperature,
  })  : _weatherIcon = weatherIcon,
        _maxTemperature = maxTemperature,
        _minTemperature = minTemperature;
  final SvgPicture? _weatherIcon;
  final int? _maxTemperature;
  final int? _minTemperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: _weatherIcon ?? const Placeholder(),
        ),
        _TemperatureLabels(
          maxTemperature: _maxTemperature,
          minTemperature: _minTemperature,
        ),
      ],
    );
  }
}

class _CommandButtons extends StatelessWidget {
  const _CommandButtons({VoidCallback? onClose, VoidCallback? onReload})
      : _onClose = onClose,
        _onReload = onReload;
  final VoidCallback? _onClose;
  final VoidCallback? _onReload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _onClose?.call,
            child: Text(
              'Close',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.blue,
                  ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _onReload?.call,
            child: Text(
              'Reload',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.blue,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({required WeatherController weatherController, super.key})
      : _weatherController = weatherController;
  final WeatherController _weatherController;

  @override
  State<WeatherPage> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherPage> {
  SvgPicture? _weatherIcon;
  int? _maxTemperature;
  int? _minTemperature;

  void _reload() {
    try {
      WeatherInfo? _weatherInfo = widget._weatherController.getWeatherInfo();
      if (_weatherInfo == null) {
        return;
      }
      setState(() {
        _weatherIcon = _weatherInfo.icon;
        _maxTemperature = _weatherInfo.maxTemperature;
        _minTemperature = _weatherInfo.minTemperature;
      });
    } on YumemiWeatherError catch (e) {
      if (mounted) {
        ErrorDialog.yumemiError(errorMessage: e.toString()).showErrorDialog(context);
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.otherError(errorMessage: e.toString()).showErrorDialog(context);
      }
    }
  }

  void _close() {
    if (context.mounted) {
      Navigator.pop(context);
    }
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
              _WeatherContainer(
                weatherIcon: _weatherIcon,
                maxTemperature: _maxTemperature,
                minTemperature: _minTemperature,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    _CommandButtons(
                      onClose: _close,
                      onReload: _reload,
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
}
