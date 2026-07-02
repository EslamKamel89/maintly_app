import 'package:dio/dio.dart';
import 'package:maintly_app/core/Errors/exception.dart';
import 'package:maintly_app/core/Errors/failure.dart';
import 'package:maintly_app/core/api_service/api_consumer.dart';
import 'package:maintly_app/core/api_service/api_interceptors.dart';
import 'package:maintly_app/core/api_service/check_internet.dart';
import 'package:maintly_app/core/api_service/end_points.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    dio.options.headers = {"Accept": "application/json"};

    dio.interceptors.add(DioInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameter}) async {
    return _request(() => dio.get(path, data: data, queryParameters: queryParameter));
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    return _request(
      () => dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      ),
    );
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    return _request(
      () => dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      ),
    );
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
  }) async {
    return _request(
      () => dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameter,
      ),
    );
  }

  Future<dynamic> _request(Future<Response> Function() callback) async {
    try {
      if (!await checkInternet()) {
        throw const OfflineFailure();
      }

      final response = await callback();

      return response.data;
    } on DioException catch (e) {
      throw ServerFailure.fromDio(e);
    } on OfflineException {
      throw const OfflineFailure();
    } on Failure {
      rethrow;
    } catch (_) {
      throw ServerFailure.unknown();
    }
  }
}
