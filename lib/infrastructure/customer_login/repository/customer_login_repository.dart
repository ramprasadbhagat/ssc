
import 'package:either_dart/either.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/customer_login/data_source/remote_data_source.dart';

class CustomerLoginRepository {
  final CustomerLoginRemoteDataSource customerLoginRemoteDataSource;

  CustomerLoginRepository({required this.customerLoginRemoteDataSource});

  Future<Either<String, CustomerInfo>> loginUser({required String mobileNumber,required String password}) async {
    try{
      final res = (await customerLoginRemoteDataSource.loginUser(mobileNumber,password));
      
      return Right(res);
    } on Exception catch (e){
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}