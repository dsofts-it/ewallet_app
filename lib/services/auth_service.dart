import 'dart:convert';

import 'package:ewallet_app/models/auth_models.dart';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  static const String _baseUrl = 'https://nirv-ico.onrender.com/api';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  final http.Client _client;

  AuthService({http.Client? client}) : _client = client ?? http.Client();

  Future<AuthInitResult> signupMobileInit({
    required String name,
    required String mobile,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/auth/signup/mobile-init'),
      headers: _headers,
      body: jsonEncode({'name': name, 'mobile': mobile}),
    );

    final data = _decodeWithCheck(response);
    final userId = _pickUserId(data);

    if (userId.isEmpty) {
      throw AuthException('Missing userId in response');
    }

    return AuthInitResult(userId: userId, mobile: mobile);
  }

  Future<AuthVerifyResult> signupVerify({
    required String userId,
    required String otp,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/auth/signup/verify'),
      headers: _headers,
      body: jsonEncode({'userId': userId, 'otp': otp, 'type': 'mobile'}),
    );

    final data = _decodeWithCheck(response);
    return _toVerifyResult(data);
  }

  Future<AuthInitResult> loginMobileInit({required String mobile}) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/auth/login/mobile-init'),
      headers: _headers,
      body: jsonEncode({'mobile': mobile}),
    );

    final data = _decodeWithCheck(response);
    final userId = _pickUserId(data);
    return AuthInitResult(userId: userId, mobile: mobile);
  }

  Future<AuthVerifyResult> loginMobileVerify({
    required String mobile,
    required String otp,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/auth/login/mobile-verify'),
      headers: _headers,
      body: jsonEncode({'mobile': mobile, 'otp': otp}),
    );

    final data = _decodeWithCheck(response);
    return _toVerifyResult(data, mobileOverride: mobile);
  }

  Map<String, dynamic> _decodeWithCheck(http.Response response) {
    final Map<String, dynamic> decoded = _decodeBody(response.body);
    final Map<String, dynamic> data = decoded['data'] is Map<String, dynamic>
        ? decoded['data']
        : decoded;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    }

    throw AuthException(_extractMessage(decoded));
  }

  Map<String, dynamic> _decodeBody(String body) {
    if (body.isEmpty) return {};
    try {
      final dynamic decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      // Ignore parsing errors and surface a generic message through the caller.
    }
    return {};
  }

  String _extractMessage(Map<String, dynamic> json) {
    final message = json['message'] ?? json['error'] ?? 'Unexpected error';
    return message.toString();
  }

  String _pickUserId(Map<String, dynamic> json) {
    final dynamic value =
        json['userId'] ?? json['user_id'] ?? json['id'] ?? json['_id'];
    if (value is String) return value;
    return '';
  }

  AuthVerifyResult _toVerifyResult(
    Map<String, dynamic> json, {
    String? mobileOverride,
  }) {
    
    final token = (json['token'] ?? json['accessToken'] ?? json['authToken'])
        ?.toString();
    if (token == null || token.isEmpty) {
      throw AuthException('Missing auth token in response');
    }

    final user = json['user'];
    final userMap = user is Map<String, dynamic> ? user : <String, dynamic>{};
    final mobile = mobileOverride ?? (userMap['mobile']?.toString() ?? '');

    return AuthVerifyResult(token: token, user: userMap, mobile: mobile);

  }
}
