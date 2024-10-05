import 'package:either_dart/either.dart';
import 'package:ssc/domain/model/service_entity.dart';
import 'package:ssc/infrastructure/service_list/data_source/service_list_remote_data_source.dart';

class ServiceListRepository {
  final ServiceListRemoteDataSource serviceListRemoteDataSource;

  ServiceListRepository({required this.serviceListRemoteDataSource});

  Future<Either<String, List<ServiceEntity>>> fetchServiceList() async {
    try{
      final res = (await serviceListRemoteDataSource.fetchServiceList());
      
      return Right(res);
    }catch(e){
      return Left(e.toString());
    }
  }
}