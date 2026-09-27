import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../core/constants/app_constants.dart';

/// HTTP API client for Khddam.ma backend
/// Handles authentication, error handling, and retry logic
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final HttpClient _httpClient = HttpClient();
  String? _authToken;
  String? _refreshToken;

  String get baseUrl => AppConstants.baseUrl;

  void setAuthToken(String token) {
    _authToken = token;
  }

  void setRefreshToken(String token) {
    _refreshToken = token;
  }

  void clearTokens() {
    _authToken = null;
    _refreshToken = null;
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (_authToken != null) 'Authorization': 'Bearer $_authToken',
      };

  /// GET request
  Future<ApiResponse> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: queryParams,
      );

      final request = await _httpClient.getUrl(uri);
      _headers.forEach((key, value) => request.headers.set(key, value));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      return ApiResponse(
        statusCode: response.statusCode,
        body: body.isNotEmpty ? jsonDecode(body) : null,
        isSuccess: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      debugPrint('API GET Error: $e');
      return ApiResponse(
        statusCode: 0,
        body: null,
        isSuccess: false,
        error: e.toString(),
      );
    }
  }

  /// POST request
  Future<ApiResponse> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = await _httpClient.postUrl(uri);
      _headers.forEach((key, value) => request.headers.set(key, value));

      if (body != null) {
        request.write(jsonEncode(body));
      }

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      return ApiResponse(
        statusCode: response.statusCode,
        body: responseBody.isNotEmpty ? jsonDecode(responseBody) : null,
        isSuccess: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      debugPrint('API POST Error: $e');
      return ApiResponse(
        statusCode: 0,
        body: null,
        isSuccess: false,
        error: e.toString(),
      );
    }
  }

  /// PUT request
  Future<ApiResponse> put(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = await _httpClient.putUrl(uri);
      _headers.forEach((key, value) => request.headers.set(key, value));

      if (body != null) {
        request.write(jsonEncode(body));
      }

      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      return ApiResponse(
        statusCode: response.statusCode,
        body: responseBody.isNotEmpty ? jsonDecode(responseBody) : null,
        isSuccess: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      debugPrint('API PUT Error: $e');
      return ApiResponse(
        statusCode: 0,
        body: null,
        isSuccess: false,
        error: e.toString(),
      );
    }
  }

  /// DELETE request
  Future<ApiResponse> delete(String endpoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = await _httpClient.deleteUrl(uri);
      _headers.forEach((key, value) => request.headers.set(key, value));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      return ApiResponse(
        statusCode: response.statusCode,
        body: body.isNotEmpty ? jsonDecode(body) : null,
        isSuccess: response.statusCode >= 200 && response.statusCode < 300,
      );
    } catch (e) {
      debugPrint('API DELETE Error: $e');
      return ApiResponse(
        statusCode: 0,
        body: null,
        isSuccess: false,
        error: e.toString(),
      );
    }
  }
}

class ApiResponse {
  final int statusCode;
  final dynamic body;
  final bool isSuccess;
  final String? error;

  const ApiResponse({
    required this.statusCode,
    this.body,
    required this.isSuccess,
    this.error,
  });

  String? get message {
    if (body is Map<String, dynamic>) {
      return body['message'] as String?;
    }
    return error;
  }

  dynamic get data {
    if (body is Map<String, dynamic>) {
      return body['data'];
    }
    return body;
  }
}
