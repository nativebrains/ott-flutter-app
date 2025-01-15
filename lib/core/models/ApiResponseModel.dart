class ApiResponseModel {
  final int status;
  final bool load_more;
  final bool user_plan_status;
  final String? currency_code;
  final dynamic data;
  final dynamic reviews;
  final String? message;

  ApiResponseModel({
    required this.status,
    this.data,
    this.currency_code,
    this.load_more = false,
    this.user_plan_status = false,
    this.reviews,
    this.message,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    int? statusCode,
  ) {
    return ApiResponseModel(
      status: json['status_code'] ?? statusCode ?? 0,
      load_more: json['load_more'] ?? false,
      currency_code: json['currency_code'] ?? "",
      user_plan_status: json['user_plan_status'] ?? false,
      data: json['VIDEO_STREAMING_APP'], // `data` can be dynamic
      reviews: json['reviews'],
      message: json['message'],
    );
  }
}
