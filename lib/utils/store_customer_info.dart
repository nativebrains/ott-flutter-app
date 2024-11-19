import 'package:shared_preferences/shared_preferences.dart';

class StoreCustomerInfo{

  static void setId(String id) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("id", id);
  }
  static Future<String?> getId() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("id");
  }


  static void setCustomerId(String consumerId) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("consumer_id", consumerId);
  }
  static Future<String?> getCustomerId() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("consumer_id");
  }


  static void setLanguageId(String languageId) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("language_id", languageId);
  }
  static Future<String?> getLanguageId() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("language_id");
  }


  static void setFirstName(String firstName) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("first_name", firstName);
  }
  static Future<String?> getFirstName() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("first_name");
  }


  static void setLastName(String lastName) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("last_name", lastName);
  }
  static Future<String?> getLastName() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("last_name");
  }


  static void setEmail(String email) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("email", email);
  }
  static Future<String?> getEmail() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("email");
  }


  static void setMobile(String mobile) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("mobile", mobile);
  }
  static Future<String?> getMobile() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("mobile");
  }


  static void setMobileCountryCode(String countryCode) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("country_code", countryCode);
  }
  static Future<String?> getMobileCountryCode() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("country_code");
  }


  static void setUserType(String userType) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("user_type", userType);
  }

  static Future<String?> getUserType() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("user_type");
  }


  static void setToken(String token) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("token", token);
  }

  static Future<String?> getToken() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("token");
  }

  static void setInviteCode(String inviteCode) async {
    final ref = await SharedPreferences.getInstance();
    ref.setString("inviteCode", inviteCode);
  }

  static Future<String?> getInviteCode() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getString("inviteCode");
  }


  static void setLoginStatus(bool status) async {
    final ref = await SharedPreferences.getInstance();
    ref.setBool("login", status);
  }

  static Future<bool?> isLogin() async {
    final ref = await SharedPreferences.getInstance();
    return ref.getBool("login");
  }


}