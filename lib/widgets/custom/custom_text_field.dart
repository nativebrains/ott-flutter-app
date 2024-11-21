import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? initialValue; // New parameter for initial value
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final EdgeInsetsGeometry contentPadding;
  final Color fillColor;
  final bool filled;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final int? minLines;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final Color? hintTextColor; // New parameter for hint text color
  final bool enabled; // New parameter for enabling/disabling the text field

  CustomTextField({
    required this.hintText,
    this.controller,
    this.initialValue, // Add initial value to constructor
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    this.fillColor = Colors.white,
    this.filled = true,
    this.prefixIcon,
    this.onChanged,
    this.textInputAction,
    this.minLines,
    this.textStyle,
    this.maxLines,
    this.textAlign = TextAlign.left,
    this.hintTextColor, // Add hint text color to constructor
    this.enabled = true, // Add enabled to constructor with default value
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController
      _textEditingController; // Controller for the text field
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _obscureText = widget.obscureText;

    // Initialize the controller with the initial value if provided
    _textEditingController = widget.controller ??
        TextEditingController(
          text: widget.initialValue, // Set the initial value
        );
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController, // Use the initialized controller
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      cursorColor: Colors.red,
      focusNode: _focusNode,
      minLines: widget.minLines,
      textAlign: widget.textAlign ?? TextAlign.left, // Align text to the right
      maxLines: widget.maxLines,
      style: widget.textStyle,
      enabled: widget.enabled, // Use the enabled property
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: widget.hintTextColor ?? Colors.grey), // Use hint text color
        contentPadding: widget.contentPadding,
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        prefixIcon: widget.prefixIcon != null
            ? Builder(
                builder: (BuildContext context) {
                  return IconTheme(
                    data: IconThemeData(
                        color: _focusNode.hasFocus ? Colors.red : Colors.grey),
                    child: widget.prefixIcon!,
                  );
                },
              )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: _focusNode.hasFocus ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
}
