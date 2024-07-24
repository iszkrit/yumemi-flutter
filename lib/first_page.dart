import 'package:flutter/material.dart';
import 'package:flutter_training/mixin/after_display_mixin.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> with AfterDisplayMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(),
    );
  }

  @override
  Future<void> afterDisplayLayout() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await Navigator.pushNamed(context, '/weather');
    }
  }
}
