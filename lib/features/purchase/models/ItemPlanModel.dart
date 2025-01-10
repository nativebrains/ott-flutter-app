class ItemPlanModel {
  String? planId;
  String? planName;
  String? planDuration;
  String? planPrice;
  String? planCurrencyCode;

  ItemPlanModel({
    this.planId,
    this.planName,
    this.planDuration,
    this.planPrice,
    this.planCurrencyCode,
  });

  factory ItemPlanModel.fromJson(Map<String, dynamic> json) {
    return ItemPlanModel(
      planId: json['plan_id'],
      planName: json['plan_name'],
      planDuration: json['plan_duration'],
      planPrice: json['plan_price'],
      planCurrencyCode: json['currency_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'planName': planName,
      'planDuration': planDuration,
      'planPrice': planPrice,
      'planCurrencyCode': planCurrencyCode,
    };
  }
}
