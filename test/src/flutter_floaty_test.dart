import 'package:flutter/material.dart';
import 'package:flutter_floaty/flutter_floaty.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generator_app_floaty.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('FlutterFloaty is created successfully', (
    WidgetTester tester,
  ) async {
    await Generator.createApp(tester);

    expect(find.text('Floaty'), findsOneWidget);
    final floaty = tester.firstWidget(find.byType(Container)) as Container;
    expect(floaty.constraints!.maxWidth, 200);
    expect(floaty.constraints!.maxHeight, 200);
  });

  testWidgets('FlutterFloaty responds to tap gestures',
      (WidgetTester tester) async {
    var tapped = false;
    final child = FlutterFloaty(
      initialX: 50,
      initialY: 50,
      width: 200,
      height: 200,
      builder: (context) => const Text('Floaty'),
      onTap: () {
        tapped = true;
      },
    );
    await Generator.createApp(tester, child: child);

    await tester.tap(find.text('Floaty'));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('FlutterFloaty can be dragged', (WidgetTester tester) async {
    await Generator.createApp(tester);

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
    final child = FlutterFloaty(
      initialX: 50,
      initialY: 50,
      width: 200,
      height: 200,
      intrinsicBoundaries: const Rect.fromLTWH(0, 0, 300, 300),
      builder: (context) => const Text('Floaty'),
    );
    await Generator.createApp(tester, child: child);

    tester.getTopLeft(find.text('Floaty'));
    await tester.drag(find.text('Floaty'), const Offset(300, 300));
    await tester.pumpAndSettle();
    final newPosition = tester.getTopLeft(find.text('Floaty'));

    expect(newPosition.dx, lessThanOrEqualTo(200)); // 300 - 200 (width)
    expect(newPosition.dy, lessThanOrEqualTo(200)); // 300 - 200 (height)
  });

  testWidgets('FlutterFloaty returns to initial position when pinned',
      (WidgetTester tester) async {
    final child = FlutterFloaty(
      initialX: 50,
      initialY: 50,
      width: 200,
      height: 200,
      pinned: true,
      builder: (context) => const Text('Floaty'),
    );
    await Generator.createApp(tester, child: child);

    await tester.drag(find.text('Floaty'), const Offset(100, 100));
    await tester.pumpAndSettle();

    final movedPosition = tester.getTopLeft(find.text('Floaty'));
    expect(movedPosition, isNot(const Offset(50, 50)));

    await tester.tapAt(const Offset(1, 1)); // Tap outside to end dragging
    await tester.pumpAndSettle();

    final resetPosition = tester.getTopLeft(find.text('Floaty'));
    expect(resetPosition.dx, 127.25);
    expect(resetPosition.dy, 160);
  });

  testWidgets('FlutterFloaty respects growing factor constraints',
      (WidgetTester tester) async {
    final child = FlutterFloaty(
      initialX: 50,
      initialY: 50,
      growingFactor: 2,
      builder: (context) => const Text('Floaty'),
    );
    await Generator.createApp(tester, child: child);

    await tester.drag(find.text('Floaty'), const Offset(1, 1));
    final floaty = tester.firstWidget(find.byType(Container)) as Container;
    await tester.pumpAndSettle();

    expect(floaty.constraints!.maxWidth, 100);
    expect(floaty.constraints!.maxHeight, 100);
  });

  testWidgets('FlutterFloaty is not visible when isVisible is false',
      (WidgetTester tester) async {
    final child = FlutterFloaty(
      initialX: 50,
      initialY: 50,
      width: 200,
      height: 200,
      isVisible: false,
      builder: (context) => const Text('Floaty'),
    );
    await Generator.createApp(tester, child: child);

    final offstageWidget = find.byType(Offstage).last;
    expect(offstageWidget, findsOneWidget);
    expect((tester.firstWidget(offstageWidget) as Offstage).offstage, isTrue);
  });

  testWidgets('FlutterFloaty handles animations correctly',
      (WidgetTester tester) async {
    final child = FlutterFloaty(
      initialX: 50,
      initialY: 50,
      width: 200,
      height: 200,
      enableAnimation: false,
      builder: (context) => const Text('Floaty'),
    );
    await Generator.createApp(tester, child: child);

    final floaty = tester.firstWidget(find.byType(Container)) as Container;
    expect(floaty.constraints!.maxWidth, 200);
    expect(floaty.constraints!.maxHeight, 200);

    await tester.drag(find.text('Floaty'), const Offset(1, 1));
    await tester.pumpAndSettle();

    final newSize = tester.firstWidget(find.byType(Container)) as Container;
    expect(newSize.constraints!.maxWidth, 200);
    expect(newSize.constraints!.maxHeight, 200);
  });
}
