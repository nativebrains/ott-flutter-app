import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //     'assets/images/error_illustration.png'),
          Text(
            kDebugMode
                ? errorDetails.summary.toString()
                : 'Server Error',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kDebugMode ? Colors.pink : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            kDebugMode
                ? 'First Check Model class then Please Contact with Api Developer. '
                :
                    "Sorry for the inconvenience caused.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
