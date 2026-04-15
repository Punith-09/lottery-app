import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  // 👉 Replace this with your base URL
  static const String baseUrl = "http://10.0.2.2:10000/api";
  // static const String baseUrl = "https://guys-announced-bra-conversations.trycloudflare.com/api";

  // Common headers
  static Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  // 🔹 GET Request
  static Future<dynamic> getRequest(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.get(url, headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  // 🔹 POST Request
  static Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  // 🔹 PUT Request
  static Future<dynamic> putRequest(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.put(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception("PUT request failed: $e");
    }
  }

  // 🔹 DELETE Request
  static Future<dynamic> deleteRequest(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.delete(url, headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception("DELETE request failed: $e");
    }
  }

  // 🔹 Response Handler
  static dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);

      case 400:
        throw Exception("Bad Request: ${response.body}");

      case 401:
      case 403:
        throw Exception("Unauthorized: ${response.body}");

      case 404:
        throw Exception("Not Found: ${response.body}");

      case 500:
        throw Exception("Server Error: ${response.body}");

      default:
        throw Exception(
            "Error occurred: ${response.statusCode} ${response.body}");
    }
  }
}