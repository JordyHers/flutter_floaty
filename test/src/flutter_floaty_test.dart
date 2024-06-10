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
                width: 200,
                height: 200,
                builder: (context) => const Text('Floaty'),
              ),
            ],
          ),
        ),
      ),
    );

    // Check if the widget is present
    expect(find.text('Floaty'), findsOneWidget);

    // Check if the widget has the correct initial size
    final floaty = tester.firstWidget(find.byType(Container)) as Container;
    expect(floaty.constraints!.maxWidth, 200);
    expect(floaty.constraints!.maxHeight, 200);
  });

  testWidgets('FlutterFloaty responds to tap gestures',
      (WidgetTester tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              FlutterFloaty(
                initialX: 50,
                initialY: 50,
                width: 200,
                height: 200,
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
                width: 200,
                height: 200,
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

  testWidgets('FlutterFloaty respects intrinsic boundaries',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              FlutterFloaty(
                initialX: 50,
                initialY: 50,
                width: 200,
                height: 200,
                intrinsicBoundaries: const Rect.fromLTWH(0, 0, 300, 300),
                builder: (context) => const Text('Floaty'),
              ),
            ],
          ),
        ),
      ),
    );

    final initialPosition = tester.getTopLeft(find.text('Floaty'));
    await tester.drag(find.text('Floaty'), const Offset(300, 300));
    await tester.pumpAndSettle();
    final newPosition = tester.getTopLeft(find.text('Floaty'));

    // Ensure the widget doesn't go out of the boundaries (300, 300 is the max)
    expect(newPosition.dx, lessThanOrEqualTo(200)); // 300 - 200 (width)
    expect(newPosition.dy, lessThanOrEqualTo(200)); // 300 - 200 (height)
  });
}
