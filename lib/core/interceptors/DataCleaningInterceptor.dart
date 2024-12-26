import 'package:dio/dio.dart';

class DataCleaningInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is Map) {
      var data = Map.of(options.data);
      // Remove keys with null, empty, or "null" string values
      data.removeWhere(
          (key, value) => value == null || value == "" || value == "null");
      options.data = data; // Update the data with cleaned map
    }
    handler.next(options);
  }
}
