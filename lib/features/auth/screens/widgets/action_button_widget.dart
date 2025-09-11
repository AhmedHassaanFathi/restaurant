import 'package:flutter/material.dart';

/// Reusable rounded button that supports:
/// - fixed width & height
/// - border radius
/// - solid color or gradient
/// - customizable text style
/// - onPressed callback
class ActionButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String text;
  final TextStyle? textStyle;                                               
  final VoidCallback onPressed;
  final Color? color; // used if gradient == null
  final Gradient? gradient;
  final double elevation;

  const ActionButton({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 30.0,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.color,
    this.gradient,
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Material + InkWell to get ripple effect while supporting gradient backgrounds
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        elevation: elevation,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: gradient == null ? (color ?? Colors.orange) : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: textStyle ??
                    const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      // default text color — assume contrasting color
                      color: Color(0xFFEF4A00),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
