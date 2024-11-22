import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextDecoration decoration;
  final Color decorationColor; // Added parameter for underline color

  final int maxLines;
  final TextOverflow overflow;
  final FontStyle fontStyle;

  CustomText({
    required this.text,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign = TextAlign.left,
    this.decorationColor = const Color(0xFFC33366),
    this.decoration = TextDecoration.none,
    this.maxLines = 10,
    this.overflow = TextOverflow.ellipsis,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor, // Apply the underline color here
        fontStyle: fontStyle,
        letterSpacing: 1, // spacing between words
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
