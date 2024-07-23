import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    required this.errorTitle,
    required this.errorMessage,
    super.key,
  });

  const ErrorDialog.yumemiError({
    required String errorMessage,
    Key? key,
  }) : this(
          key: key,
          errorTitle: 'YumemiWeatherErrorのエラー',
          errorMessage: errorMessage,
        );

  const ErrorDialog.otherError({
    required String errorMessage,
    Key? key,
  }) : this(key: key, errorTitle: 'その他のエラー', errorMessage: errorMessage);

  final String errorTitle;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('YumemiWeatherErrorのエラー'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('errorTitle', errorTitle));
    properties.add(StringProperty('errorMessage', errorMessage));
  }
}
