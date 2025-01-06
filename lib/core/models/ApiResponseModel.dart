class ApiResponseModel {
  final int status;
  final bool load_more;
  final bool user_plan_status;
  final dynamic data;

  ApiResponseModel({
    required this.status,
    this.data,
    this.load_more = false,
    this.user_plan_status = false,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    int? statusCode,
  ) {
    return ApiResponseModel(
      status: json['status_code'] ?? statusCode ?? 0,
      load_more: json['load_more'] ?? false,
      user_plan_status: json['user_plan_status'] ?? false,
      data: json['VIDEO_STREAMING_APP'], // `data` can be dynamic
    );
  }
}
