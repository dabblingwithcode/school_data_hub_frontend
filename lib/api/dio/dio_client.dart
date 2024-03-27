import 'package:dio/dio.dart';
import 'package:schuldaten_hub/api/dio/dio_interceptor.dart';
import 'package:schuldaten_hub/api/endpoints.dart';

import 'package:schuldaten_hub/common/utils/debug_printer.dart';

class DioClient {
  // dio instance
  final Dio _dio;
  final String? token;
  final String? baseUrl;
  final bool? isFile;
  String? user;

  // injecting dio instance
  DioClient(this._dio, this.token, this.baseUrl, this.isFile) {
    if (token == '') {
      debug.success('DioClient with no token!');
    } else {
      debug.success('DioClient has a token! | ${StackTrace.current}');
    }
    _dio
      ..options.baseUrl = baseUrl!
      ..options.connectTimeout = Endpoints.connectionTimeout
      //..options.headers['content-Type'] = 'application/json'
      ..options.headers['x-access-token'] = token
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(DioInterceptor())
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  //- GET:-----------------------------------------------------------------------

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      debug.info('request sent:, $uri | ${StackTrace.current}');
      return response;
    } catch (e) {
      debug.error('Dio error: $e in request:, $uri | ${StackTrace.current}');

      rethrow;
    }
  }

//- PATCH:-----------------------------------------------------------------------

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //- POST:----------------------------------------------------------------------

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      debug.info('request sent:, $uri | ${StackTrace.current}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //- PUT:-----------------------------------------------------------------------

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //- DELETE:--------------------------------------------------------------------

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
