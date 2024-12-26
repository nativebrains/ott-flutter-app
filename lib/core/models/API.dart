import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class API {
  late String sign;
  late String salt;

  API() {
    String apiKey = 'viaviweb';
    salt = getRandomSalt().toString();
    sign = generatemd5(apiKey + salt);
  }

  /// Generate a random salt value between 0 and 899
  int getRandomSalt() {
    Random random = Random();
    return random.nextInt(900);
  }

  /// Generate an MD5 hash from the given input
  String generatemd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// Encode a string to Base64
  static String toBase64(String input) {
    return base64Encode(utf8.encode(input));
  }

  /// Decode a Base64 string
  static String fromBase64(String input) {
    return utf8.decode(base64Decode(input));
  }
}
