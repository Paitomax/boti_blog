import 'package:flutter/material.dart';

mixin BotiAlertDialogShow {
  Widget get widget;

  BuildContext get parentContext;

  void show({bool dismissible = true}) {
    showDialog<void>(
      context: parentContext,
      barrierDismissible: dismissible,
      builder: (BuildContext dialogContext) {
        return widget;
      },
    );
  }
}
