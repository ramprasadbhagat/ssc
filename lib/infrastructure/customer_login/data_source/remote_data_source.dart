import 'package:dio/dio.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/core/dio_service.dart';

class CustomerLoginRemoteDataSource {
  DioService dioService;
  CustomerLoginRemoteDataSource({required this.dioService});
  Future<CustomerInfo> loginUser(String mobileNumber, String password) async {
    final res = await dioService.post(endpoint: 'Auth/login', data: {
      "mobileNo": mobileNumber,
      "email": '',
      "password": password,
    });

    _exceptionHandler(res);


    return CustomerInfo.fromMap(res.data)
        .copyWith(cookie: _getToken(res.headers.map['set-cookie'] ?? []));
  }

  String _getToken(List list){
    if(list.isEmpty) return '';
    return list.join('');
  }

  void _exceptionHandler(Response res) {
    if (res.data['message'] == 'Invalid Password') {
      throw Exception('${res.data['message']}');
    }
    if (res.statusCode != 200) {
      throw Exception('${res.statusMessage}');
    }
  }
}
