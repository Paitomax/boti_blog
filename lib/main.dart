import 'package:botiblog/src/app/boti_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

final releaseMode = true;

void main() async {
  runApp(
    DevicePreview(
      enabled: !releaseMode,
      builder: (context) => BotiApp(),
    ),
  );
}
