/*
*  shadows.dart
*  Simposi App Designs V3.0
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/rendering.dart';


class Shadows {
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(26, 0, 0, 0),
    offset: Offset(0, 2),
    blurRadius: 7,
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color.fromARGB(39, 0, 0, 0),
    offset: Offset(0, -5),
    blurRadius: 30,
  );
}