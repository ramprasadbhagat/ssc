
import 'package:either_dart/either.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/customer_sign_up/data_source/remote_data_source.dart';

class CustomerSignUpRepository {
  final CustomerSignUpRemoteDataSource customerSignUpRemoteDataSource;

  CustomerSignUpRepository({required this.customerSignUpRemoteDataSource});

  Future<Either<String, CustomerInfo>> registerUser({required CustomerInfo customerInfo}) async {
    try{
      final res = (await customerSignUpRemoteDataSource.registerUser(customerInfo));
      
      return Right(res);
    }on Exception catch (e){
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}