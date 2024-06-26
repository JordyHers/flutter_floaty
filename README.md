
![FlutterFloaty](https://github.com/JordyHers/flutter_floaty/assets/49708438/9442d2b0-4a02-40d1-bb14-cccebc380e6d)

# flutter_floaty

This repository contains various examples of floating action buttons using the `FlutterFloaty` widget in Flutter. The `FlutterFloaty` widget allows users to create customizable, draggable, and animated floating buttons.

## Features

- Customizable floating buttons
- Smooth animations when dragging
- Different shapes and sizes
- Changeable background colors
- Optional shadow effects
- Accessibility support
- Visibility with `isVisible` property
- onHover functionality 
- Intrinsic boundaries


## Demo

<img src="https://github.com/JordyHers/flutter_floaty/assets/49708438/75043045-31f4-454b-b54b-fb02af749bcc" width="323">

## Examples

### Basic Floating Button

A simple floating button with text and rounded corners.

```dart

// Set up exact boundaries in which the widget is draggable
final boundaries =  Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width,
    MediaQuery.of(context).size.height * 0.75,
    );

FlutterFloaty(
  intrinsicBoundaries: boundaries,
  width: 200,
  height: 50,
  builder: (context) => const Text(
    'Flutter Floaty 🎉',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.blue,
  onDragBackgroundColor: Colors.blueAccent,
  borderRadius: 10,
  growingFactor: 1.3,
)
```

### Rounded Floating Button with Icon

A circular button with an icon in the center.

```dart
FlutterFloaty(
  width: 60,
  height: 60,
  initialX: 100,
  initialY: 300,
  builder: (context) => const Icon(
    Icons.add,
    color: Colors.white,
  ),
  backgroundColor: Colors.green,
  onDragBackgroundColor: Colors.greenAccent,
  borderRadius: 30,
  growingFactor: 1.3,
)
```

### Square Floating Button with Text

A square-shaped button with text in the center.

```dart
FlutterFloaty(
  width: 100,
  height: 100,
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

)
```

### Circular Floating Button with Emoji

A circular button displaying an emoji.

```dart
FlutterFloaty(
  width: 80,
  height: 80,
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
  
)
```

### Floating Button with Shadow

A button with a shadow effect.

```dart
FlutterFloaty(
  width: 150,
  height: 50,
  initialX: 50,
  initialY: 500,
  builder: (context) => const Text(
    'Shadow Floaty',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.orange,
  onDragBackgroundColor: Colors.orangeAccent,
  borderRadius: 25,
  shadow: BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 5,
    blurRadius: 10,
    offset: const Offset(0, 3),
  ),
)
```

## Complex Example

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
                  width: 300,
                  height: 150,
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
                  width: 200,
                  height: 150,
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
               ),
               FlutterFloaty(
                  width: 70,
                  height: 70,
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
               ),

               FlutterFloaty(
                  width: 200,
                  height: 50,
                  builder: (context) => const Text(
                     'Flutter Floaty 🎉',
                     style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                  onDragBackgroundColor: Colors.blueAccent,
               ),
               FlutterFloaty(
                  width: 100,
                  height: 100,
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
               ),
               FlutterFloaty(
                  width: 60,
                  height: 60,
                  initialX: 100,
                  initialY: 300,
                  builder: (context) => const Icon(
                     Icons.add,
                     color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                  onDragBackgroundColor: Colors.greenAccent,
                  borderRadius: 30,
               ),
               FlutterFloaty(
                  width: 70,
                  height: 70,
                  builder: (context) => const Icon(
                     Icons.person,
                     size: 55,
                  ),
                  backgroundColor: Colors.transparent,
                  onDragBackgroundColor: Colors.transparent,
                  borderRadius: 35,
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
- **width**: `double` - Initial width of the widget.
- **height**: `double` - Initial height of the widget.
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
- **onHover**: `VoidCallback?` - Callback when the user hovers with mouse.
- **isVisible**: `bool?` - To hide and show the widget based on state.
- **intrinsicBoundaries**: `Rect?` - To determine the boundaries in which the widget is draggable
- **enableAnimation**: `bool?` - To enable the growing effect on Widget drag.
- **onPausePlaceHolder**: `Widget?` - Placeholder widget builder to show when the drag ends.

## Getting Started

1. **Clone the repository:**
   ```sh
   git clone https://github.com/jordyhers/flutter_floaty.git
   ```

2. **Navigate to the project directory:**
   ```sh
   cd flutter_floaty
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

