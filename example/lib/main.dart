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
          // Music Player Control with Progress Bar
          FlutterFloaty(
            initialWidth: 300,
            initialHeight: 150,
            initialX: 50,
            initialY: 150,
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: togglePlayPause,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Now Playing: Flutter Beats',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: progress,
                    color: Colors.red,
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${elapsed.inMinutes}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')} / ${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            onDragBackgroundColor: Colors.black87,
          ),
          // Picture-in-Picture Video
          FlutterFloaty(
            initialWidth: 200,
            initialHeight: 150,
            initialX: 100,
            initialY: 350,
            builder: (context) => Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://i3.ytimg.com/vi/erLk59H86ww/maxresdefault.jpg',
                  ),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            onDragBackgroundColor: Colors.black54,
            growingFactor: 10,
          ),
          FlutterFloaty(
            initialWidth: 70,
            initialHeight: 70,
            builder: (context) => Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://avatars.githubusercontent.com/u/9919?s=280&v=4',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            onDragBackgroundColor: Colors.transparent,
            borderRadius: 35,
            growingFactor: 5,
          ),

          FlutterFloaty(
            initialWidth: 200,
            initialHeight: 50,
            initialY: 100,
            initialX: 100,
            pinned: true,
            builder: (context) => const Text(
              'Pinned Flutter Floaty 🎉',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
            onDragBackgroundColor: Colors.blueAccent,
          ),
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
          FlutterFloaty(
            initialWidth: 70,
            initialHeight: 70,
            builder: (context) => const Icon(
              Icons.person,
              size: 55,
            ),
            backgroundColor: Colors.transparent,
            onDragBackgroundColor: Colors.transparent,
            borderRadius: 35,
            growingFactor: 5,
          ),
        ],
      ),
    );
  }
}
