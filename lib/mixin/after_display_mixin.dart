import 'package:flutter/material.dart';

mixin AfterDisplayMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    Future(
      () async {
        await WidgetsBinding.instance.endOfFrame;
        afterDisplayLayout();
      },
    );
  }

  void afterDisplayLayout();
}
