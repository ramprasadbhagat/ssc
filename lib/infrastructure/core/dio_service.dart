import 'package:dio/dio.dart';
import 'package:ssc/config.dart';
import 'package:ssc/presentation/helper/share_preference_helper.dart';

class DioService {
  final Dio _dio = Dio();

  DioService({required Config config}) {

    _dio.options = BaseOptions(
      baseUrl: config.uatBaseUrl, // Replace with your base URL
      connectTimeout: Duration(seconds :config.httpConnectTimeout),
      receiveTimeout: Duration(seconds :config.httpReceiveTimeout),
      sendTimeout: Duration(seconds :config.httpSendTimeout),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<dynamic> get({required String endpoint, Map<String, dynamic>? queryParams}) async {
    try {
      final cookie = await SharedPreferencesHelper().getCookie() ?? '';
      if(cookie.isNotEmpty) {
        _dio.options.headers['Cookie'] = cookie;
      }
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return response;
    }  on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> post({required String endpoint, Map<String, dynamic>? data}) async {
    try {
      final cookie = await SharedPreferencesHelper().getCookie() ?? '';
      if(cookie.isNotEmpty) {
        _dio.options.headers['Cookie'] = cookie;
      }
      Response response = await _dio.post(
        endpoint,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      if(e.response != null) return e.response!;
      rethrow; 
    }
  }
}
