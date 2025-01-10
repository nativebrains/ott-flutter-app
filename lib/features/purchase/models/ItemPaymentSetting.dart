class ItemPaymentSetting {
  int? gatewayId;
  String? status;
  String? gatewayName;
  String? currencyCode;
  dynamic gatewayInfo;
  String? stripePublisherKey;
  String? razorPayKey;
  String? payStackPublicKey;
  bool? isPayPal;
  bool? isStripe;
  bool? isRazorPay;
  bool? isPayStack;
  bool? isPayUMoney;
  bool? isPayUMoneySandbox;
  String? payUMoneyMerchantId;
  String? payUMoneyMerchantKey;
  bool? isInstaMojo;
  bool? isInstaMojoSandbox;
  bool? isPayTM;
  bool? isPayTMSandbox;
  String? payTMMid;
  bool? isCashFree;
  bool? isCashFreeSandbox;
  String? cashFreeAppId;
  bool? isFlutterWave;
  String? fwPublicKey;
  String? fwEncryptionKey;
  bool? isCoinGate;
  bool? isMollie;
  bool? isBankTransfer;
  String? bankTransferTitle;
  String? bankTransferInfo;
  bool? isSsl;
  bool? isSslSandbox;
  String? sslStoreId;
  String? sslStorePassword;
  bool? isCinetPay;
  String? cpApiKey;
  String? cpSiteId;

  ItemPaymentSetting({
    this.gatewayId,
    this.status,
    this.gatewayName,
    this.gatewayInfo,
    this.currencyCode,
    this.stripePublisherKey,
    this.razorPayKey,
    this.payStackPublicKey,
    this.isPayPal,
    this.isStripe,
    this.isRazorPay,
    this.isPayStack,
    this.isPayUMoney,
    this.isPayUMoneySandbox,
    this.payUMoneyMerchantId,
    this.payUMoneyMerchantKey,
    this.isInstaMojo,
    this.isInstaMojoSandbox,
    this.isPayTM,
    this.isPayTMSandbox,
    this.payTMMid,
    this.isCashFree,
    this.isCashFreeSandbox,
    this.cashFreeAppId,
    this.isFlutterWave,
    this.fwPublicKey,
    this.fwEncryptionKey,
    this.isCoinGate,
    this.isMollie,
    this.isBankTransfer,
    this.bankTransferTitle,
    this.bankTransferInfo,
    this.isSsl,
    this.isSslSandbox,
    this.sslStoreId,
    this.sslStorePassword,
    this.isCinetPay,
    this.cpApiKey,
    this.cpSiteId,
  });

  factory ItemPaymentSetting.fromJson(Map<String, dynamic> json) {
    return ItemPaymentSetting(
      gatewayId: json['gateway_id'],
      gatewayInfo: json['gateway_info'],
      gatewayName: json['gateway_name'],
      status: json['status'],
      currencyCode: json['currency_code'],
      stripePublisherKey: json['stripe_publisher_key'],
      razorPayKey: json['razor_pay_key'],
      payStackPublicKey: json['pay_stack_public_key'],
      isPayPal: json['is_pay_pal'],
      isStripe: json['is_stripe'],
      isRazorPay: json['is_razor_pay'],
      isPayStack: json['is_pay_stack'],
      isPayUMoney: json['is_pay_u_money'],
      isPayUMoneySandbox: json['is_pay_u_money_sandbox'],
      payUMoneyMerchantId: json['pay_u_money_merchant_id'],
      payUMoneyMerchantKey: json['pay_u_money_merchant_key'],
      isInstaMojo: json['is_insta_mojo'],
      isInstaMojoSandbox: json['is_insta_mojo_sandbox'],
      isPayTM: json['is_pay_tm'],
      isPayTMSandbox: json['is_pay_tm_sandbox'],
      payTMMid: json['pay_tm_mid'],
      isCashFree: json['is_cash_free'],
      isCashFreeSandbox: json['is_cash_free_sandbox'],
      cashFreeAppId: json['cash_free_app_id'],
      isFlutterWave: json['is_flutter_wave'],
      fwPublicKey: json['fw_public_key'],
      fwEncryptionKey: json['fw_encryption_key'],
      isCoinGate: json['is_coin_gate'],
      isMollie: json['is_mollie'],
      isBankTransfer: json['is_bank_transfer'],
      bankTransferTitle: json['bank_transfer_title'],
      bankTransferInfo: json['bank_transfer_info'],
      isSsl: json['is_ssl'],
      isSslSandbox: json['is_ssl_sandbox'],
      sslStoreId: json['ssl_store_id'],
      sslStorePassword: json['ssl_store_password'],
      isCinetPay: json['is_cinet_pay'],
      cpApiKey: json['cp_api_key'],
      cpSiteId: json['cp_site_id'],
    );
  }
}
