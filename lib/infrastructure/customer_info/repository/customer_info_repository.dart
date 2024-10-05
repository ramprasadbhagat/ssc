
import 'package:either_dart/either.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/customer_info/data_source/customer_info_remote_data_source.dart';

class CustomerInfoRepository {
  final CustomerInfoRemoteDataSource customerInfoRemoteDataSource;

  CustomerInfoRepository({required this.customerInfoRemoteDataSource});

  Future<Either<String, CustomerInfo>> getCustomerInfo({required CustomerInfo customerInfo}) async {
    try{
      final res = (await customerInfoRemoteDataSource.getCustomerInfo(customerInfo));
      
      return Right(res);
    }on Exception catch (e){
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}