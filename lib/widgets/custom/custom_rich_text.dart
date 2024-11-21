import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class CustomRichText extends StatelessWidget {
  final String leadingText;
  final String actionText;
  final Function()? onActionTap;
  final double fontSize;
  final double actionFontSize;
  final Color leadingTextColor;
  final Color actionTextColor;
  final bool isLeadingUnderlined;
  final bool isActionUnderlined;
  final bool isLeadingBold;
  final bool isActionBold;

  CustomRichText({
    required this.leadingText,
    required this.actionText,
    this.onActionTap,
    this.fontSize = 16.0,
    this.actionFontSize = 16.0,
    this.leadingTextColor = Colors.black,
    this.actionTextColor = Colors.black,
    this.isLeadingUnderlined = false,
    this.isActionUnderlined = true,
    this.isLeadingBold = false,
    this.isActionBold = true,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          decoration: TextDecoration.none,
        ),
        children: <TextSpan>[
          TextSpan(
            text: leadingText,
            style: TextStyle(
              color: leadingTextColor,
              fontWeight: isLeadingBold ? FontWeight.bold : FontWeight.normal,
              decoration: isLeadingUnderlined
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
          TextSpan(
            text: actionText,
            style: TextStyle(
              fontSize: actionFontSize,
              color: actionTextColor,
              fontWeight: isActionBold ? FontWeight.bold : FontWeight.normal,
              decoration: isActionUnderlined
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (onActionTap != null) {
                  onActionTap!();
                }
              },
          ),
        ],
      ),
    );
  }
}
