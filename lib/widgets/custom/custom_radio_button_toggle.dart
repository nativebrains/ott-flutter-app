import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioButtonToggle extends StatelessWidget {
  final bool value; // Current state
  final ValueChanged<bool> onChanged; // Callback for changes
  final String text; // Label text

  const CustomRadioButtonToggle({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value); // Toggle the value
      },
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? Colors.greenAccent : Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: value
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp, // Adjust based on your app's design
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
