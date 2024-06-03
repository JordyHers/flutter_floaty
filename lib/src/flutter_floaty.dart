import 'package:flutter/material.dart';
import 'package:flutter_floaty/src/config/config.dart';

/// Signature for a function that handles the start of a drag event.
typedef DragStartCallback = void Function(DragStartDetails details);

/// Signature for a function that handles the update of a drag event.
typedef DragUpdateCallback = void Function(DragUpdateDetails details);

/// Signature for a function that handles the end of a drag event.
typedef DragEndCallback = void Function(DragEndDetails details);

/// Signature for a function that handles hover events.
typedef HoverCallback = void Function({bool isHovering});

/// Signature for a function that builds a widget with the provided context.
typedef WidgetBuilder = Widget Function(BuildContext context);

/// A widget that can be placed, dragged, and dropped anywhere on the screen.
///
/// [FlutterFloaty] allows users to interact with the widget through drag
/// gestures. It supports customizations for the drag start, update, end,
/// and hover events. It also accepts a builder function to display the content
/// within the draggable area.
class FlutterFloaty extends StatefulWidget {
  /// Creates a floating draggable widget.
  ///
  /// The [builder] parameter must not be null.
  const FlutterFloaty({
    required this.builder,
    super.key,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onHover,
    this.initialX = 0,
    this.initialY = 0,
    this.initialWidth = 100,
    this.initialHeight = 100,
    this.backgroundColor = Colors.black,
    this.onDragBackgroundColor = Colors.grey,
    this.onHoverBackgroundColor,
    this.accessibilityLabel,
    this.pinned = false,
    this.growingFactor = 1,
    this.margin,
    this.padding,
    this.borderRadius = 10,
    this.shape,
    this.shadow,
    this.scale = 1.0,
    this.onTap,
    this.onPausePlaceHolder,
    this.isVisible = true,
    this.intrinsicBoundaries,
    this.enableAnimation = true,
  });

  /// Callback when the drag starts.
  final DragStartCallback? onDragStart;

  /// Callback when the drag is updated.
  final DragUpdateCallback? onDragUpdate;

  /// Callback when the drag ends.
  final DragEndCallback? onDragEnd;

  /// Callback when the widget is hovered over.
  final HoverCallback? onHover;

  /// The builder function to display the content within the draggable area.
  final WidgetBuilder builder;

  /// Initial horizontal position of the widget.
  final double initialX;

  /// Initial vertical position of the widget.
  final double initialY;

  /// Initial width of the widget.
  final double initialWidth;

  /// Initial height of the widget.
  final double initialHeight;

  /// Initial color of the widget.
  final Color backgroundColor;

  /// Background color when the widget is being dragged.
  final Color onDragBackgroundColor;

  /// Background color when the widget is hovered over.
  final Color? onHoverBackgroundColor;

  /// Accessibility label for the widget.
  final String? accessibilityLabel;

  /// Whether the widget is pinned to an initial position.
  final bool pinned;

  /// The factor by which the widget grows when dragged.
  final double growingFactor;

  /// Margin for the container.
  final EdgeInsetsGeometry? margin;

  /// Padding for the container.
  final EdgeInsetsGeometry? padding;

  /// Border radius for the container.
  final double borderRadius;

  /// Shape for the container.
  final BoxShape? shape;

  /// Shadow for the container.
  final BoxShadow? shadow;

  /// Scale for the Transform.scale widget.
  final double scale;

  /// Callback when the widget is tapped.
  final VoidCallback? onTap;

  /// Placeholder widget builder to show when the drag ends.
  final Widget? onPausePlaceHolder;

  /// Visibility of the widget.
  final bool isVisible;

  /// Intrinsic boundaries within which the widget can be dragged.
  final Rect? intrinsicBoundaries;

  /// Disable Animation to avoid growing widget on drag
  final bool enableAnimation;

  @override
  State<FlutterFloaty> createState() => _FlutterFloatyState();
}

class _FlutterFloatyState extends State<FlutterFloaty>
    with SingleTickerProviderStateMixin {
  late double xPosition;
  late double yPosition;
  late double width;
  late double height;
  late Color backgroundColor;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _xPositionAnimation;
  late Animation<double> _yPositionAnimation;

  @override
  void initState() {
    super.initState();
    xPosition = widget.initialX;
    yPosition = widget.initialY;
    width = widget.initialWidth * widget.growingFactor;
    height = widget.initialHeight * widget.growingFactor;
    backgroundColor = widget.backgroundColor;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addListener(() {
      if (widget.enableAnimation) {
        setState(() {
          width = widget.initialWidth * _animation.value * widget.growingFactor;
          height =
              widget.initialHeight * _animation.value * widget.growingFactor;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initAsserts(context);
    return Positioned(
      left: xPosition,
      top: yPosition,
      child: Offstage(
        offstage: !widget.isVisible,
        child: MouseRegion(
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          child: GestureDetector(
            onTap: widget.onTap,
            onPanStart: _onPanStart,
            onPanUpdate: (details) {
              _onPanUpdate(details, context);
            },
            onPanEnd: _onPanEnd,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Semantics(
                  label: widget.accessibilityLabel,
                  child: Transform.scale(
                    scale: widget.scale,
                    child: Container(
                      margin: widget.margin,
                      padding: widget.padding,
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        shape: widget.shape ?? BoxShape.rectangle,
                        boxShadow:
                            widget.shadow != null ? [widget.shadow!] : [],
                      ),
                      child: Center(
                        child: widget.builder(context),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    _controller.forward();
    setState(() {
      backgroundColor = widget.onDragBackgroundColor;
    });
    if (widget.onDragStart != null) {
      widget.onDragStart?.call(details);
    }
  }

  void _onPanEnd(DragEndDetails details) {
    _controller.reverse();
    setState(() {
      backgroundColor = widget.backgroundColor;
    });
    if (widget.pinned) {
      _animateTransition();
    }
    if (widget.onDragEnd != null) {
      widget.onDragEnd?.call(details);
    }
  }

  void _onPanUpdate(DragUpdateDetails details, BuildContext context) {
    setState(() {
      final defaultBoundaries = Rect.fromLTWH(
        0,
        0,
        Config.dynamicWidth(context),
        Config.dynamicHeight(context) * 0.85,
      );
      final newX = xPosition + details.delta.dx;
      final newY = yPosition + details.delta.dy;
      final boundaries = widget.intrinsicBoundaries ?? defaultBoundaries;

      xPosition = newX.clamp(boundaries.left, boundaries.right - width);
      yPosition = newY.clamp(boundaries.top, boundaries.bottom - height);
    });
    if (widget.onDragUpdate != null) {
      widget.onDragUpdate?.call(details);
    }
  }

  void _onHover(bool isHovering) {
    if (widget.onHover != null) {
      widget.onHover?.call(isHovering: isHovering);
    }
    setState(() {
      backgroundColor = isHovering
          ? (widget.onHoverBackgroundColor ?? widget.backgroundColor)
          : widget.backgroundColor;
    });
  }

  void _animateTransition() {
    _xPositionAnimation = Tween<double>(
      begin: xPosition,
      end: widget.initialX,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _yPositionAnimation = Tween<double>(
      begin: yPosition,
      end: widget.initialY,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller
      ..addListener(() {
        setState(() {
          xPosition = _xPositionAnimation.value;
          yPosition = _yPositionAnimation.value;
        });
      })
      ..forward(from: 0);
  }

  void _initAsserts(BuildContext context) {
    assert(
      context.findAncestorWidgetOfExactType<Stack>() != null,
      'FlutterFloaty must be placed inside a Stack widget.',
    );
    final screenWidth = Config.dynamicWidth(context);
    assert(
      widget.initialWidth <= screenWidth,
      'initialWidth (${widget.initialWidth}) must not be greater than screen '
      'width ($screenWidth).',
    );
    assert(
      widget.growingFactor <= screenWidth,
      'initialWidth (${widget.initialWidth}) must not be greater than screen '
      'width ($screenWidth).',
    );

    assert(
      widget.growingFactor >= 1 && widget.growingFactor <= 2,
      'growingFactor (${widget.growingFactor}) must be between 1 and 2 and '
      'animation should be enabled.',
    );
  }
}
