import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();

  SharedPreferences? _preferences;

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setCustomerLoginState(bool isLoggedIn) async {
    await _preferences?.setBool('isCustomerLoggedIn', isLoggedIn);
  }

  Future<void> setEngineerLoginState(bool isLoggedIn) async {
    await _preferences?.setBool('isEngineerLoggedIn', isLoggedIn);
  }

  bool getCustomerLoginState() {
    return _preferences?.getBool('isCustomerLoggedIn') ?? false;
  }

  bool getEngineerLoginState() {
    return _preferences?.getBool('isEngineerLoggedIn') ?? false;
  }


  //store credentials
  Future<void> setMobileNumber(String mobileNumber) async {
    await _preferences?.setString('mobileNumber', mobileNumber);
  }

  String? getMobileNumber() {
    return _preferences?.getString('mobileNumber');
  }

  Future<void> setPassword(String password) async {
    await _preferences?.setString('password', password);
  }

  String? getPassword() {
    return _preferences?.getString('password');
  }

  Future<void> setCookie(String cookie) async {
    await _preferences?.setString('cookie', cookie);
  }

  String? getCookie() {
    return _preferences?.getString('cookie');
  }

  Future<void> clearCredentials() async {
    await _preferences?.remove('mobileNumber');
    await _preferences?.remove('password');
    await _preferences?.remove('cookie');
    await _preferences?.remove('isCustomerLoggedIn');
    await _preferences?.remove('isEngineerLoggedIn');
  }
}
