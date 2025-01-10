class ItemDashBoardModel {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userPhone;
  String? currentPlan;
  String? expiresOn;
  String? lastInvoiceDate;
  String? lastInvoicePlan;
  String? lastInvoiceAmount;

  ItemDashBoardModel({
    this.userName,
    this.userEmail,
    this.userImage,
    this.currentPlan,
    this.expiresOn,
    this.lastInvoiceDate,
    this.lastInvoicePlan,
    this.lastInvoiceAmount,
    this.userPhone,
  });

  factory ItemDashBoardModel.fromJson(Map<String, dynamic> json) {
    return ItemDashBoardModel(
      userName: json['name'],
      userEmail: json['email'],
      userImage: json['user_image'],
      userPhone: json['phone'],
      currentPlan: json['current_plan'],
      expiresOn: json['expires_on'],
      lastInvoiceDate: json['last_invoice_date'],
      lastInvoicePlan: json['last_invoice_plan'],
      lastInvoiceAmount: json['last_invoice_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': userName,
      'email': userEmail,
      'user_image': userImage,
      'current_plan': currentPlan,
      'expires_on': expiresOn,
      'last_invoice_date': lastInvoiceDate,
      'last_invoice_plan': lastInvoicePlan,
      'last_invoice_amount': lastInvoiceAmount,
    };
  }
}
