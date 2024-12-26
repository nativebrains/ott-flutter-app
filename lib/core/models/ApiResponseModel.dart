class ApiResponseModel {
  final int status;
  final dynamic data;

  ApiResponseModel({
    required this.status,
    this.data,
  });

  factory ApiResponseModel.fromJson(
      Map<String, dynamic> json, int? statusCode) {
    return ApiResponseModel(
      status: json['status_code'] ?? statusCode ?? 0,
      data: json['VIDEO_STREAMING_APP'], // `data` can be dynamic
    );
  }
}
