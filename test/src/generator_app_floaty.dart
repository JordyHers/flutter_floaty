import 'package:flutter/material.dart';
import 'package:flutter_floaty/flutter_floaty.dart';
import 'package:flutter_test/flutter_test.dart';

class Generator {
  static Future<void> createApp(WidgetTester tester, {Widget? child}) async =>
      tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                child ??
                    FlutterFloaty(
                      initialX: 50,
                      initialY: 50,
                      width: 200,
                      height: 200,
                      builder: (context) => const Text('Floaty'),
                    ),
              ],
            ),
          ),
        ),
      );
}
