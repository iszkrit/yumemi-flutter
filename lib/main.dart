import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon();

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1,
      child: Placeholder(),
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
  const _WeatherContainer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _WeatherIcon(),
        _TemperatureLabels(),
      ],
    );
  }
}

class _CommandButtons extends StatelessWidget {
  const _CommandButtons();

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
            onPressed: () {},
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(
              children: [
                Spacer(),
                _WeatherContainer(),
                Flexible(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      _CommandButtons(),
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
