import 'package:dio/dio.dart';
import 'package:ssc/domain/model/service_entity.dart';
import 'package:ssc/infrastructure/core/dio_service.dart';

class ServiceListRemoteDataSource {
  DioService dioService;
  ServiceListRemoteDataSource({required this.dioService});
  Future<List<ServiceEntity>> fetchServiceList() async {
    final res = await dioService.get(endpoint: 'AppService/ServiceList');

    _exceptionHandler(res);


    return List.from(res.data).map((e)=> ServiceEntity.fromMap(e)).toList();
  }

  void _exceptionHandler(Response res) {
    if(res.statusCode == 201) return;
    if (res.statusCode != 200) {
      throw Exception('${res.statusMessage}');
    }
  }
}
