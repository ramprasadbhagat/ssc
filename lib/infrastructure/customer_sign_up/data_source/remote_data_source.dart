
import 'package:dio/dio.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/core/dio_service.dart';

class CustomerSignUpRemoteDataSource {
  DioService dioService;
  CustomerSignUpRemoteDataSource({required this.dioService});
  Future<CustomerInfo> registerUser(CustomerInfo customerInfo) async {
      final res = await dioService.post(endpoint: 'Auth/register', data: {
        "name": customerInfo.name,
        "email": customerInfo.email,
        "password": customerInfo.address,
        "mobileNo": customerInfo.phoneNumber,
        "address": customerInfo.address
      });

      _exceptionHandler(res);

      return CustomerInfo.fromMap(res.data);
  }


  void _exceptionHandler(Response res){
    if (res.statusCode == 201 && res.data == 'User Already Exists'){
      throw Exception('${res.data}');
    } else if(res.statusCode != 200){
      throw Exception('${res.statusMessage}');
    }
  }
}
