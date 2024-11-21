import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final Widget? leadingIcon; // New property for leading icon

  CustomElevatedButton({
    required this.label,
    required this.onPressed,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.pink,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(0.0),
    this.elevation = 2.0,
    this.borderRadius = 12.0,
    this.borderColor = Colors.pink,
    this.borderWidth = 0.0,
    this.leadingIcon, // Initialize the leadingIcon property
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: GradientElevatedButton(
        onPressed: onPressed,
        style: GradientElevatedButton.styleFrom(
          gradient: const LinearGradient(
            colors: [
              Colors.orange,
              Colors.pink,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          surfaceTintColor: backgroundColor,
          padding: padding,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              SizedBox(width: 8.sp)
            ], // If there's a leading icon, add it before the text
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
