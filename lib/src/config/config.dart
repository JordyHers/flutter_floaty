import 'package:flutter/material.dart';

/// [Config] file creates the widget
/// parent height and width constraints
///
class Config {
  Config._();

  ///[dynamicHeight] used to calculate height
  static double dynamicHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  ///[dynamicWidth] used to calculate width
  static double dynamicWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
