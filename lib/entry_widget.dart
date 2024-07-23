import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EntryWidget extends StatefulWidget {
  const EntryWidget({super.key});

  @override
  EntryWidgetState createState() => EntryWidgetState();
}

class EntryWidgetState extends State<EntryWidget> with AfterDisplayMixin {
  @override
  void initState() {
    super.initState();
    Future(() async {
      await afterDisplayLayout();
    });
  }

  @override
  Future<void> afterDisplayLayout() async {
    await SchedulerBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await Navigator.pushNamed(context, '/weather');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}

mixin AfterDisplayMixin on State<EntryWidget> {
  Future<void> afterDisplayLayout();
}
