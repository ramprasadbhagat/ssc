import 'package:dartz/dartz.dart';
import 'package:ssc/domain/model/customer/customer_info.dart';
import 'package:ssc/infrastructure/auth/data_source/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepository({required this.authRemoteDataSource});

  Future<Either<String, Unit>> storeCredential(
      {required String phoneNumber, required String password,  required String cookie}) async {
    try {
      await authRemoteDataSource.storeCredential(
          phoneNumber: phoneNumber, password: password, cookie: cookie);

      return Right(unit);
    } on Exception {
      rethrow;
    }
  }

  Future<Either<String, CustomerInfo>> getCredential() async {
    try {
      final res = await authRemoteDataSource.getCredential();

      return Right(res);
    } on Exception {
      rethrow;
    }
  }


  Future<Either<String, Unit>> clearCredential() async {
    try {
      await authRemoteDataSource.clearCredential();

      return Right(unit);
    } on Exception {
      rethrow;
    }
  }
}
