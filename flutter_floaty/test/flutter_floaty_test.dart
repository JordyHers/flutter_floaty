import 'package:flutter/material.dart';
import 'package:flutter_floaty/flutter_floaty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('FlutterFloaty is created successfully',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              FlutterFloaty(
                initialX: 50,
                initialY: 50,
                initialWidth: 200,
                initialHeight: 200,
                builder: (context) => const Text('Floaty'),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Floaty'), findsOneWidget);
  });

  testWidgets('FlutterFloaty responds to tap gestures',
      (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              FlutterFloaty(
                initialX: 50,
                initialY: 50,
                initialWidth: 200,
                initialHeight: 200,
                builder: (context) => const Text('Floaty'),
                onTap: () {
                  tapped = true;
                },
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Floaty'));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('FlutterFloaty can be dragged', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              FlutterFloaty(
                initialX: 50,
                initialY: 50,
                initialWidth: 200,
                initialHeight: 200,
                builder: (context) => const Text('Floaty'),
              ),
            ],
          ),
        ),
      ),
    );

    final initialPosition = tester.getTopLeft(find.text('Floaty'));

    await tester.drag(find.text('Floaty'), const Offset(200, 200));
    await tester.pumpAndSettle();

    final newPosition = tester.getTopLeft(find.text('Floaty'));

    expect(newPosition, isNot(initialPosition));
    expect(newPosition.dx, initialPosition.dx + 200);
    expect(newPosition.dy, initialPosition.dy + 200);
  });
}
