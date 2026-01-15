// button_depth.dart
import 'package:flutter/material.dart';

class ButtonDepth {
  static const raised = [
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 14,
      color: Color(0x33000000), // ~20% black
    ),
  ];

  static const pressed = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 6,
      color: Color(0x22000000),
    ),
  ];

  static const disabled = [];
}
