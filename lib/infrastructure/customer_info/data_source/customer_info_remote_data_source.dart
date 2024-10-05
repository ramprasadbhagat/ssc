import 'package:dio/dio.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/core/dio_service.dart';

class CustomerInfoRemoteDataSource {
  DioService dioService;
  CustomerInfoRemoteDataSource({required this.dioService});
  Future<CustomerInfo> getCustomerInfo(CustomerInfo customerInfo) async {
    final res = await dioService.get(
        endpoint:
            'Auth/user?username=${customerInfo.phoneNumber}&password=${customerInfo.password}');

    _exceptionHandler(res);

    return CustomerInfo.fromMap(res.data);
  }

  void _exceptionHandler(Response res) {
    if (res.statusCode != 200) {
      throw Exception('${res.statusMessage}');
    }
  }
}
