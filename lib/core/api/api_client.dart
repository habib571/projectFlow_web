import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:projectflow_web/core/cache/local_storage.dart';
import 'package:projectflow_web/core/constants/endpoints.dart';

import 'api_response.dart';

class ApiClient {
  final Dio _dio;
  String? _accessToken;
  String? _refreshToken;
  final LocalStorage _localStorage;

  ApiClient(this._localStorage)
      : _dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (status) => status != null && status <= 500,
    ),
  ) {
    _init();
  }

  Future<void> _init() async {
    await getToken();
  /*  _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('[REQUEST] ${options.method} ${options.baseUrl}${options.path}');
          log('[DATA] ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('[RESPONSE] ${response.statusCode}: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          log('[ERROR] ${e.message}');
          if (e.response?.statusCode == 401 && _refreshToken != null) {
            bool refreshed = await _refreshAccessToken();
            if (refreshed) {
              return handler.resolve(await _retryRequest(e.requestOptions));
            }
          }
          return handler.next(e);
        },
      ),
    );*/
  }

  Future<void> getToken() async {
    _accessToken = await _localStorage.load(key: "token", boxName: "userData");
    log("Token loaded: $_accessToken");
  }

  Future<bool> _refreshAccessToken() async {
    try {
      final response = await _dio.post(
        '/refresh-token',
        data: {'refreshToken': _refreshToken},
      );
      if (response.statusCode == 200) {
        _accessToken = response.data['accessToken'];
        await _localStorage.save(
            key: "token", value: _accessToken, boxName: "userData");
        return true;
      }
    } catch (e) {
      log("[REFRESH TOKEN FAILED] ${e.toString()}");
    }
    return false;
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {'Authorization': 'Bearer $_accessToken'},
    );
    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<ApiResponse> execute<T>({
    required Method method,
    required String url,
    Map<String, dynamic>? body,
    bool isTokenRequired = true,
    required ApiResponse Function(dynamic result, int statusCode)
    onRequestResponse,
  }) async {
    final stopwatch = Stopwatch()..start();
    await getToken();
    log("Token loading: ${stopwatch.elapsedMilliseconds} ms");

    Options options = Options(
      headers: isTokenRequired
          ? {'Authorization': 'Bearer $_accessToken'}
          : {},
    );

    Response response;

    switch (method) {
      case Method.get:
        response = await _dio.get(url, options: options);
        break;
      case Method.post:
        response = await _dio.post(url, data: body, options: options);
        break;
      case Method.put:
        response = await _dio.put(url, data: body, options: options);
        break;
      case Method.patch:
        response = await _dio.patch(url, data: body, options: options);
        break;
      case Method.delete:
        response = await _dio.delete(url, options: options);
        break;
    }

    dynamic jsonResult = response.data;
    if (jsonResult is! Map && jsonResult is! List) {
      try {
        jsonResult = json.decode(jsonResult.toString());
      } catch (_) {
        log('[WARNING] Failed to decode response body');
      }
    }

    log("[API FINAL RESULT] $jsonResult");

    return onRequestResponse(jsonResult, response.statusCode ?? 500);
  }
}

enum Method { get, post, put, patch, delete }
