class ItemPlanModel {
  int? planId;
  String? planName;
  String? planDuration;
  String? planPrice;
  String? planCurrencyCode;
  int? planDeviceLimit;
  int? adsOnOff;

  ItemPlanModel({
    this.planId,
    this.planName,
    this.planDuration,
    this.planPrice,
    this.planCurrencyCode,
    this.planDeviceLimit,
    this.adsOnOff,
  });

  factory ItemPlanModel.fromJson(Map<String, dynamic> json) {
    return ItemPlanModel(
      planId: json['plan_id'],
      planName: json['plan_name'],
      planDuration: json['plan_duration'],
      planPrice: json['plan_price'],
      planCurrencyCode: json['currency_code'],
      planDeviceLimit: json['plan_device_limit'],
      adsOnOff: json['ads_on_off'],
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
