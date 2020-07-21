
import 'package:flutter/material.dart';


// Style Background Color
const Color _backgroundColor = Color.fromARGB(255, 255, 255, 255);

// Style Border
const BorderSide _borderSide = BorderSide(
  color: Color.fromARGB(255, 255, 1, 126),
  width: 1.5,
  style: BorderStyle.solid,
);

// Style Corner Radius
const BorderRadiusGeometry _cornerRadius = BorderRadius.all(Radius.circular(10));


class YoureGoingBadgeDecoration extends BoxDecoration {
  const YoureGoingBadgeDecoration({
    Color color = _backgroundColor,
    Gradient gradient,
    Border border = const Border.fromBorderSide(_borderSide),
    BorderRadiusGeometry borderRadius = _cornerRadius,
    List<BoxShadow> boxShadow,
  }) : super(
         color: color,
         border: border,
         borderRadius: borderRadius,
         boxShadow: boxShadow,
         gradient: gradient,
       );
  
  YoureGoingBadgeDecoration.withOverrides({
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
         border: Border.fromBorderSide(_borderSide.copyWith(width: borderWidth, color: borderColor)),
         boxShadow: [ BoxShadow(color: shadowColor ?? const Color(0x00000000), offset: shadowOffset ?? Offset.zero, blurRadius: shadowRadius ?? 0.0) ]
       );
}


class YoureGoingBadge extends StatelessWidget {
  const YoureGoingBadge({
    Key key,
    this.decoration = const YoureGoingBadgeDecoration(),
    this.child,
  }) : super(key: key);
  final YoureGoingBadgeDecoration decoration;
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
  
    return DecoratedBox(
      decoration: this.decoration,
      child: this.child,
    );
  }
}


class YoureGoingBadgeButton extends StatelessWidget {
  
  const YoureGoingBadgeButton({
    Key key,
    this.color = _backgroundColor,
    this.border = _borderSide,
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
      child: this.child,
    );
  }
}


class YoureGoingBadgeSwitch extends StatelessWidget {
  const YoureGoingBadgeSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.activeColor,
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


class YoureGoingBadgeSlider extends StatelessWidget {
  const YoureGoingBadgeSlider({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.inactiveColor = _backgroundColor,
    this.activeColor,
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


class YoureGoingBadgeCircularProgressIndicator extends StatelessWidget {
  const YoureGoingBadgeCircularProgressIndicator({
    Key key,
    this.color,
  }): super(key: key);
  final Color color;
  
  @override
  Widget build(BuildContext context) {
  
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}


class YoureGoingBadgeLinearProgressIndicator extends StatelessWidget {
  const YoureGoingBadgeLinearProgressIndicator({
    Key key,
    this.color,
  }): super(key: key);
  final Color color;
  
  @override
  Widget build(BuildContext context) {
  
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(this.color),
    );
  }
}