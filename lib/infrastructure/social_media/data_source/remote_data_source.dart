
import 'package:dio/dio.dart';
import 'package:ssc/domain/model/customer/social_media.dart';
import 'package:ssc/infrastructure/core/dio_service.dart';

class SocialMediaRemoteDataSource {
  DioService dioService;
  SocialMediaRemoteDataSource({required this.dioService});
  Future<SocialMedia> getSocialMediaUrls() async {
      final res = await dioService.get(endpoint: 'AppService/socialmedia');

      _exceptionHandler(res);

      return SocialMedia.fromMap(res.data);
  }


  void _exceptionHandler(Response res){
    if (res.statusCode == 201){
      return;
    } else if(res.statusCode != 200){
      throw Exception('${res.statusMessage}');
    }
  }
}
