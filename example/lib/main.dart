import 'package:flutter/material.dart';
import 'package:flutter_floaty/flutter_floaty.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const backgroundColor = Color(0xFFF1EFE7);
  bool isPlaying = false;
  double progress = 0;
  Duration elapsed = Duration.zero;
  final Duration totalDuration = const Duration(minutes: 3);

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      _startProgress();
    } else {
      _stopProgress();
    }
  }

  void _startProgress() {
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!isPlaying) return false;
      setState(() {
        elapsed += const Duration(seconds: 1);
        progress = elapsed.inSeconds / totalDuration.inSeconds;
      });
      return elapsed < totalDuration;
    });
  }

  void _stopProgress() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FlutterFloaty Example'),
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        children: [
          FlutterFloaty(
            pinned: true,
            intrinsicBoundaries: Rect.fromLTWH(
              0,
              0,
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.75,
            ),
            initialWidth: 120,
            initialHeight: 40,
            initialY: 100,
            initialX: 100,
            builder: (context) => const Text(
              'Pinned Flutter Floaty 🎉',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            onDragBackgroundColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
