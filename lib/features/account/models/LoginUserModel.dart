class LoginUserModel {
  String userSessionName;
  bool deviceLimitReached;
  int userId;
  String name;
  String email;
  String phone;
  String userImage;
  String message;

  LoginUserModel({
    required this.userSessionName,
    required this.deviceLimitReached,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.userImage,
    required this.message,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      userSessionName: json['user_session_name'],
      deviceLimitReached: json['device_limit_reached'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userImage: json['user_image'],
      message: json['msg'],
    );
  }

  // Add this method to your UserModel class
  Map<String, dynamic> toJson() {
    return {
      'user_session_name': userSessionName,
      'device_limit_reached': deviceLimitReached,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'user_image': userImage,
      'message': message,
    };
  }
}
