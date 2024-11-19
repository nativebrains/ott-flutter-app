class ApiResponseModel {
  final int status;
  final String message;
  final dynamic data;
  final Map<String, List<String>>? errors; // Handle errors as a map of lists

  ApiResponseModel({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponseModel.fromJson(
      Map<String, dynamic> json, int? statusCode) {
    // Handle errors field, which can be a map
    Map<String, List<String>>? errors = null;
    if (json['errors'] != null) {
      // Check if it's a map
      if (json['errors'] is Map<String, dynamic>) {
        errors = {};
        (json['errors'] as Map<String, dynamic>).forEach((key, value) {
          // Convert each value to a list of strings
          errors![key] = List<String>.from(value);
        });
      } else if (json['errors'] is List<dynamic>) {
        // If it's a list of errors, map them to strings
        errors = {'general': List<String>.from(json['errors'])};
      }
    }
    return ApiResponseModel(
      status: json['status'] ?? statusCode ?? 0,
      message: json['message'] ?? '',
      data: json['data'], // `data` can be dynamic
      errors: errors,
    );
  }
}

dynamic extractData(dynamic data) {
  if (data is Map) {
    return data; // If it's a map (object), return it
  } else if (data is List) {
    return data; // If it's a list, return it
  } else {
    return null; // Handle empty or unexpected types
  }
}
