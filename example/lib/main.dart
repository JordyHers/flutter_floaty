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
  double progress = 0;
  double width = 200;
  double height = 50;

  void _resolveHeight() {
    setState(() {
      width = 400;
      height = 100;
    });
  }

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
            onTap: _resolveHeight,
            width: width,
            height: height,
            initialY: 50,
            initialX: 100,
            pinned: true,
            enableAnimation: false,
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
