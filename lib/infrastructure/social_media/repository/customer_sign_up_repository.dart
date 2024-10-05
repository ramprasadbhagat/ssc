
import 'package:either_dart/either.dart';
import 'package:ssc/domain/model/customer/social_media.dart';
import 'package:ssc/infrastructure/social_media/data_source/remote_data_source.dart';

class SocialMediaRepository {
  final SocialMediaRemoteDataSource socialMediaRemoteDataSource;

  SocialMediaRepository({required this.socialMediaRemoteDataSource});

  Future<Either<String, SocialMedia>> getSocialMediaUrls() async {
    try{
      final res = await socialMediaRemoteDataSource.getSocialMediaUrls();
      
      return Right(res);
    }on Exception catch (e){
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}