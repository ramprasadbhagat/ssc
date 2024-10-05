import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/presentation/helper/share_preference_helper.dart';

class AuthRemoteDataSource {
  Future<void> clearCredential() async {
    try{
      await SharedPreferencesHelper().clearCredentials();
    } catch(e){
      throw Exception(e.toString());
    }
  }

  Future<CustomerInfo> getCredential() async {
    try{
      final pref = SharedPreferencesHelper();
    String? phoneNumber = pref.getMobileNumber();
    String? password = pref.getPassword();
    String? cookie = pref.getCookie();
    return CustomerInfo.empty()
        .copyWith(phoneNumber: phoneNumber, password: password, cookie: cookie);
    } catch(e){
       throw Exception(e.toString());
    }
  }

  Future<void> storeCredential(
      {required String phoneNumber, required String password, required String cookie}) async {
    try{
      final pref = SharedPreferencesHelper();
    await pref.setMobileNumber(phoneNumber);
    await pref.setPassword(password);
    await pref.setCookie(cookie);

    await pref.setCustomerLoginState(true);
    } catch(e){
       throw Exception(e.toString());
    }
  }

  
}