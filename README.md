# flutter_floaty



This repository contains various examples of floating action buttons using the `FlutterFloaty` widget in Flutter. The `FlutterFloaty` widget allows users to create customizable, draggable, and animated floating buttons.

## Features

- Customizable floating buttons
- Smooth animations when dragging
- Different shapes and sizes
- Changeable background colors
- Optional shadow effects
- Accessibility support

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

