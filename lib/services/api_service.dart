import 'dart:convert';

import 'package:ewallet_app/constants/app_config.dart';
import 'package:ewallet_app/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _client;
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await _client.post(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: await _headers(token),
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> get(String endpoint, {String? token}) async {
    final response = await _client.get(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: await _headers(token),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await _client.put(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: await _headers(token),
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  Future<void> delete(String endpoint, {String? token}) async {
    final response = await _client.delete(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: await _headers(token),
    );
    _handleResponse(response, expectBody: false);
  }

  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final response = await _client.patch(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: await _headers(token),
      body: body != null ? json.encode(body) : null,
    );
    return _handleResponse(response);
  }

  Future<Map<String, String>> _headers(String? token) async {
    final resolvedToken = token ?? await StorageService.getToken();
    return {
      'Content-Type': 'application/json',
      if (resolvedToken != null && resolvedToken.isNotEmpty)
        'Authorization': 'Bearer $resolvedToken',
    };
  }

  dynamic _handleResponse(http.Response response, {bool expectBody = true}) {
    final status = response.statusCode;
    dynamic decoded = {};
    if (response.body.isNotEmpty) {
      try {
        decoded = json.decode(response.body);
      } catch (_) {
        decoded = {};
      }
    }

    if (status >= 200 && status < 300) {
      return expectBody ? decoded : null;
    }

    final message = decoded is Map<String, dynamic>
        ? decoded['message'] ?? decoded['error'] ?? 'Unexpected error'
        : 'Unexpected error';
    throw Exception(message.toString());
  }
}
