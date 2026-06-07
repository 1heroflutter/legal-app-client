import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl =
      'http://192.168.1.155:5000/api';

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    Map<String, dynamic> body = {};
    try {
      body = json.decode(response.body);
    } catch (_) {
      // Do nothing if response body is not a valid JSON
    }

    if (response.statusCode == 200) {
      return body;
    } else {
      // Lấy câu trả lời thân thiện (answer) hoặc thông điệp (message) từ backend
      final friendlyMsg = body['answer'] ?? body['message'] ?? body['error'] ?? 'Đã xảy ra sự cố kết nối (${response.statusCode})';
      throw Exception(friendlyMsg);
    }
  }
}
