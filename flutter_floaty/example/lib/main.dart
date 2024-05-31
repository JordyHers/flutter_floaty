import 'package:flutter/material.dart';
import 'package:flutter_floaty/flutter_floaty.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('FlutterFloaty Example')),
      body: Stack(
        children: [
          FlutterFloaty(
            initialWidth: 200,
            initialHeight: 50,
            builder: (context) => const Text(
              'Hello, World!',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            onDragBackgroundColor: Colors.blueAccent,
          ),
          FlutterFloaty(
            initialHeight: 250,
            builder: (context) => const Icon(
              Icons.star,
              size: 50,
              color: Colors.yellow,
            ),
            backgroundColor: Colors.transparent,
            onDragBackgroundColor: Colors.transparent,
          ),

          // Basic Floating Button
          FlutterFloaty(
            initialWidth: 200,
            initialHeight: 50,
            builder: (context) => const Text(
              'Flutter Floaty 🎉',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            onDragBackgroundColor: Colors.blueAccent,
            borderRadius: 10,
            growingFactor: 20,
          ),
          // Rounded Floating Button with Icon
          FlutterFloaty(
            initialWidth: 60,
            initialHeight: 60,
            initialX: 100,
            initialY: 300,
            builder: (context) => const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            onDragBackgroundColor: Colors.greenAccent,
            borderRadius: 30,
            growingFactor: 10,
          ),
          // Square Floating Button with Text
          FlutterFloaty(
            initialWidth: 100,
            initialHeight: 100,
            initialX: 200,
            initialY: 200,
            builder: (context) => const Center(
              child: Text(
                'Square',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.red,
            onDragBackgroundColor: Colors.redAccent,
            borderRadius: 0,
            growingFactor: 15,
          ),
          // Circular Floating Button with Emoji
          FlutterFloaty(
            initialWidth: 80,
            initialHeight: 80,
            initialX: 250,
            initialY: 400,
            builder: (context) => const Center(
              child: Text(
                '😊',
                style: TextStyle(fontSize: 32),
              ),
            ),
            backgroundColor: Colors.purple,
            onDragBackgroundColor: Colors.purpleAccent,
            borderRadius: 40,
          ),
          // Floating Button with Shadow
          FlutterFloaty(
            initialWidth: 150,
            initialHeight: 50,
            initialX: 50,
            initialY: 500,
            builder: (context) => const Text(
              'Shadow Floaty',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange,
            onDragBackgroundColor: Colors.orangeAccent,
            borderRadius: 20,
            growingFactor: 15,
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ),
        ],
      ),
    );
  }
}
