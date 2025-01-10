import 'package:islamforever/features/purchase/models/ItemTransactionModel.dart';

class ItemDashBoardModel {
  int? userId;
  String? userName;
  String? userEmail;
  String? userImage;
  String? userPhone;
  String? currentPlan;
  String? expiresOn;
  String? lastInvoiceDate;
  String? lastInvoicePlan;
  String? lastInvoiceAmount;
  List<ItemTransactionModel>? transactionsList;

  ItemDashBoardModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userImage,
    this.currentPlan,
    this.expiresOn,
    this.lastInvoiceDate,
    this.lastInvoicePlan,
    this.lastInvoiceAmount,
    this.userPhone,
    this.transactionsList = const [],
  });

  factory ItemDashBoardModel.fromJson(Map<String, dynamic> json) {
    return ItemDashBoardModel(
      userId: json['user_id'],
      userName: json['name'],
      userEmail: json['email'],
      userImage: json['user_image'],
      userPhone: json['phone'],
      currentPlan: json['current_plan'],
      expiresOn: json['expires_on'],
      lastInvoiceDate: json['last_invoice_date'],
      lastInvoicePlan: json['last_invoice_plan'],
      lastInvoiceAmount: json['last_invoice_amount'],
      transactionsList: (json['transactions_list'] as List?)
              ?.map((transaction) => ItemTransactionModel.fromJson(transaction))
              .toList() ??
          [],
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
