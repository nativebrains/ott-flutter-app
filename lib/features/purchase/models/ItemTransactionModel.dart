class ItemTransactionModel {
  String? planName;
  String? planAmount;
  String? paymentGateway;
  dynamic paymentId;
  String? paymentDate;
  String? paymentCurrency;

  ItemTransactionModel({
    this.planName,
    this.planAmount,
    this.paymentGateway,
    this.paymentId,
    this.paymentDate,
    this.paymentCurrency,
  });

  factory ItemTransactionModel.fromJson(Map<String, dynamic> json) {
    return ItemTransactionModel(
      planName: json['plan_name'],
      planAmount: json['amount'],
      paymentGateway: json['payment_gateway'],
      paymentId: json['payment_id'],
      paymentDate: json['payment_date'],
      paymentCurrency: json['currency_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planName': planName,
      'planAmount': planAmount,
      'paymentGateway': paymentGateway,
      'paymentId': paymentId,
      'paymentDate': paymentDate,
      'paymentCurrency': paymentCurrency,
    };
  }
}
