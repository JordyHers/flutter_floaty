
![FlutterFloaty](https://github.com/JordyHers/flutter_floaty/assets/49708438/ddd4e041-a4b6-4821-9087-6c8a210e26a0)

# flutter_floaty

This repository contains various examples of floating action buttons using the `FlutterFloaty` widget in Flutter. The `FlutterFloaty` widget allows users to create customizable, draggable, and animated floating buttons.

## Features

- Customizable floating buttons
- Smooth animations when dragging
- Different shapes and sizes
- Changeable background colors
- Optional shadow effects
- Accessibility support

## Demo

https://github.com/JordyHers/flutter_floaty/assets/49708438/14f63af5-8335-448e-9142-0331940e0782


## Examples

### Basic Floating Button

A simple floating button with text and rounded corners.

```dart
FlutterFloaty(
  initialWidth: 200,
  initialHeight: 50,
  builder: (context) => const Text(
    'Flutter Floaty 🎉',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.blue,
  onDragBackgroundColor: Colors.blueAccent,
  borderRadius: BorderRadius.circular(10),
  growingFactor: 20,
)
```

### Rounded Floating Button with Icon

A circular button with an icon in the center.

```dart
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
  borderRadius: BorderRadius.circular(30),
  growingFactor: 10,
)
```

### Square Floating Button with Text

A square-shaped button with text in the center.

```dart
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
  borderRadius: BorderRadius.circular(0),
  growingFactor: 15,
)
```

### Circular Floating Button with Emoji

A circular button displaying an emoji.

```dart
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
  borderRadius: BorderRadius.circular(40),
  growingFactor: 20,
)
```

### Floating Button with Shadow

A button with a shadow effect.

```dart
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
  borderRadius: BorderRadius.circular(25),
  growingFactor: 15,
  shadow: BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 10,
    offset: const Offset(0, 3),
  ),
)
```

### Complex Example

```dart
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
      await Future.delayed(const Duration(seconds: 1));
      if (!isPlaying) return false;
      setState(() {
        elapsed += const Duration(seconds: 1);
        progress = elapsed.inSeconds / totalDuration.inSeconds;
      });
      return elapsed < totalDuration;
    });
  }

  void _stopProgress() {
    // No need for any specific logic in this simple demo
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
                    color: Colors.blue,
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
            backgroundColor: Colors.black,
            onDragBackgroundColor: Colors.black87,
            borderRadius: 10,
            growingFactor: 20,
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
                      'https://avatars.githubusercontent.com/u/9919?s=280&v=4'),
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
```





## Parameters

Here are the parameters used in the `FlutterFloaty` widget:

- **builder**: `WidgetBuilder` - The builder function to display the content within the draggable area.
- **initialX**: `double` - Initial horizontal position of the widget.
- **initialY**: `double` - Initial vertical position of the widget.
- **initialWidth**: `double` - Initial width of the widget.
- **initialHeight**: `double` - Initial height of the widget.
- **backgroundColor**: `Color` - Initial color of the widget.
- **onDragBackgroundColor**: `Color` - Background color when the widget is being dragged.
- **borderRadius**: `BorderRadius` - Border radius for the container.
- **growingFactor**: `double` - The factor by which the widget grows when dragged.
- **margin**: `EdgeInsetsGeometry?` - Margin for the container.
- **padding**: `EdgeInsetsGeometry?` - Padding for the container.
- **shape**: `BoxShape?` - Shape for the container.
- **shadow**: `BoxShadow?` - Shadow for the container.
- **scale**: `double` - Scale for the Transform.scale widget.
- **onTap**: `VoidCallback?` - Callback when the widget is tapped.
- **onPausePlaceHolder**: `Widget?` - Placeholder widget builder to show when the drag ends.

## Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/flutter_floaty_examples.git
   ```

2. **Navigate to the project directory:**
   ```sh
   cd flutter_floaty_examples
   ```

3. **Install dependencies:**
   ```sh
   flutter pub get
   ```

4. **Run the project:**
   ```sh
   flutter run
   ```

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.




### Integration tests 🧪

Very Good Flutter Plugin uses [fluttium][fluttium_link] for integration tests. Those tests are located 
in the front facing package `flutter_floaty` example. 

**❗ In order to run the integration tests, you need to have the `fluttium_cli` installed. [See how][fluttium_install].**

To run the integration tests, run the following command from the root of the project:

```sh
cd flutter_floaty/example
fluttium test flows/test_platform_name.yaml
```

