import 'dart:ui';

import 'package:flutter/material.dart';


class DesignAppTheme {
  DesignAppTheme._();

  static const Color light_grey = Color(0xFF48515B);
  static const Color grey = Color(0xFF616161);
  static const Color primary_Dark = Color(0xFFF57C00);
  static const Color primary = Color(0xFFFF9800);
  static const Color primary_light = Color(0xFFFFE0B2);
  static const Color accent = Color(0xFFFF5722);
  static const Color themecolor = Color(0xFFFF7964);
  static const Color white = Color(0xFFFFFFFF);
  static const Color text_primary = Colors.black;
  static const Color text_secondary = Color(0xFF757575);
  static const Color divider = Color(0xFFBDBDBD);
  static const Color light_blue = Color(0xFFE7EFF7);
  static const Color dark_blue = Color(0xFFC1C1EA);
  static const Color Bright_gray  = Color(0xFFEBECF0);
  static const Color pink  = Color(0xFFFFC0CB);
  static const Color peachpuff  = Color(0xFFFFDAB9);

  static const List<Color> orangeGradients = [
    Color(0xFFFE8853),
    Color(0xFFFD7267),
  ];

  static const BoxDecoration appBarGradient = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: DesignAppTheme.orangeGradients));


}
