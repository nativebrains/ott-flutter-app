class ReviewModel {
  int? id;
  String? review;
  int? rating;
  String? status;
  String? type;
  int? userId;
  int? moduleId;
  String? createdAt;
  String? updatedAt;
  UserModel? user;

  ReviewModel({
    required this.id,
    required this.review,
    required this.rating,
    required this.status,
    required this.type,
    required this.userId,
    required this.moduleId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      review: json['review'],
      rating: json['rating'],
      status: json['status'],
      type: json['type'],
      userId: json['user_id'],
      moduleId: json['module_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

class UserModel {
  int? id;
  String? usertype;
  int? loginStatus;
  String? googleId;
  String? facebookId;
  String? name;
  String? email;
  String? phone;
  String? userAddress;
  String? userImage;
  int? status;
  int? planId;
  int? startDate;
  int? expDate;
  String? planAmount;
  String? confirmationCode;
  String? sessionId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  UserModel({
    required this.id,
    required this.usertype,
    required this.loginStatus,
    this.googleId,
    this.facebookId,
    required this.name,
    required this.email,
    required this.phone,
    this.userAddress,
    this.userImage,
    required this.status,
    required this.planId,
    required this.startDate,
    required this.expDate,
    required this.planAmount,
    this.confirmationCode,
    required this.sessionId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      usertype: json['usertype'],
      loginStatus: json['login_status'],
      googleId: json['google_id'],
      facebookId: json['facebook_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      userAddress: json['user_address'],
      userImage: json['user_image'],
      status: json['status'],
      planId: json['plan_id'],
      startDate: json['start_date'],
      expDate: json['exp_date'],
      planAmount: json['plan_amount'],
      confirmationCode: json['confirmation_code'],
      sessionId: json['session_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}
