/*
*  dark_grey_button.dart
*  Simposi App Designs V3.0
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:flutter/material.dart';


// Style Background Color
const Color _backgroundColor = Color.fromARGB(255, 45, 46, 48);

// Style Corner Radius
const BorderRadiusGeometry _cornerRadius = BorderRadius.all(Radius.circular(25));

// Style Foreground Color
const Color _foregroundColor = Color.fromARGB(255, 255, 255, 255);

// Style Font
const double _fontSize = 15;
const FontWeight _fontWeight = FontWeight.w800;
const String _fontFamily = "Muli";
const FontStyle _fontStyle = null;


class DarkGreyButtonDecoration extends BoxDecoration {
  const DarkGreyButtonDecoration({
    Color color = _backgroundColor,
    Gradient gradient,
    Border border,
    BorderRadiusGeometry borderRadius = _cornerRadius,
    List<BoxShadow> boxShadow,
  }) : super(
         color: color,
         border: border,
         borderRadius: borderRadius,
         boxShadow: boxShadow,
         gradient: gradient,
       );
  
  DarkGreyButtonDecoration.withOverrides({
    Color color = _backgroundColor,
    Gradient gradient,
    double borderWidth,
    Color borderColor,
    BorderRadiusGeometry borderRadius = _cornerRadius,
    Color shadowColor,
    Offset shadowOffset,
    double shadowRadius,
  }) : super(
         color: color,
         borderRadius: borderRadius,
         gradient: gradient,
         border: Border.all(width: borderWidth ?? 0.0, color: borderColor ?? const Color(0xFF000000)),
         boxShadow: [ BoxShadow(color: shadowColor ?? const Color(0x00000000), offset: shadowOffset ?? Offset.zero, blurRadius: shadowRadius ?? 0.0) ]
       );
}


class DarkGreyButtonTextStyle extends TextStyle {
  const DarkGreyButtonTextStyle({
    Color color = _foregroundColor,
    double fontSize = _fontSize,
    FontWeight fontWeight = _fontWeight,
    String fontFamily = _fontFamily,
    FontStyle fontStyle = _fontStyle,
    double height,
    double letterSpacing,
  }) : super(
         color: color,
         fontSize: fontSize,
         fontWeight: fontWeight,
         fontFamily: fontFamily,
       );
}


class DarkGreyButton extends StatelessWidget {
  const DarkGreyButton({
    Key key,
    this.decoration = const DarkGreyButtonDecoration(),
    this.child,
  }) : super(key: key);
  final DarkGreyButtonDecoration decoration;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
  
    return DefaultTextStyle(
      style: const DarkGreyButtonTextStyle(),
      child: DecoratedBox(
        decoration: this.decoration,
        child: this.child,
      ),
    );
  }
}


class DarkGreyButtonButton extends StatelessWidget {
  
  const DarkGreyButtonButton({
    Key key,
    this.color = _backgroundColor,
    this.border = const BorderSide(),
    this.borderRadius = _cornerRadius,
    this.padding,
    @required this.onPressed,
    @required this.child,
  }): super(key: key);
  
  final Color color;
  final BorderSide border;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
  
    return FlatButton(
      color: this.color,
      shape: RoundedRectangleBorder(
        side: this.border,
        borderRadius: this.borderRadius,
      ),
      onPressed: this.onPressed,
      child: DefaultTextStyle(
        style: const DarkGreyButtonTextStyle(),
        child: this.child,
      ),
    );
  }
}


class DarkGreyButtonSwitch extends StatelessWidget {
  const DarkGreyButtonSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor = _foregroundColor,
  }): super(key: key);
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  
  @override
  Widget build(BuildContext context) {
  
    return Switch.adaptive(
      value: this.value,
      onChanged: this.onChanged,
      activeColor: this.activeColor,
    );
  }
}


class DarkGreyButtonSlider extends StatelessWidget {
  const DarkGreyButtonSlider({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.inactiveColor = _backgroundColor,
    this.activeColor = _foregroundColor,
    this.min,
    this.max,
  }): super(key: key);
  final double value;
  final ValueChanged<double> onChanged;
  final Color inactiveColor;
  final Color activeColor;
  final double min;
  final double max;
  
  @override
  Widget build(BuildContext context) {
  
    return Slider(
      value: this.value,
      onChanged: this.onChanged,
      activeColor: this.activeColor,
    );
  }
}


class DarkGreyButtonCircularProgressIndicator extends StatelessWidget {
  const DarkGreyButtonCircularProgressIndicator({
    Key key,
    this.color = _foregroundColor,
  }): super(key: key);
  final Color color;
  
  @override
  Widget build(BuildContext context) {
  
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}


class DarkGreyButtonLinearProgressIndicator extends StatelessWidget {
  const DarkGreyButtonLinearProgressIndicator({
    Key key,
    this.color = _foregroundColor,
  }): super(key: key);
  final Color color;
  
  @override
  Widget build(BuildContext context) {
  
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}