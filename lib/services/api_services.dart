import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottery_app/models/transcation_model.dart';

class ApiServices {
  // 👉 Base URL
  static const String baseUrl = "http://10.0.2.2:10000/api";

  // 🍪 Single global cookie
  static String? cookie;

  // 🔹 Headers
  static Map<String, String> get _headers => {
    "Content-Type": "application/json",
    "Accept": "application/json",
    if (cookie != null) "Cookie": cookie!,
  };

  // =========================
  // 🍪 COOKIE STORAGE
  // =========================

  static Future<void> saveCookie(String cookieValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("cookie", cookieValue);
  }

  static Future<void> loadCookie() async {
    final prefs = await SharedPreferences.getInstance();
    cookie = prefs.getString("cookie");
  }

  static Future<void> clearCookie() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("cookie");
    cookie = null;
  }

  // =========================
  // GET
  // =========================
  static Future<dynamic> getRequest(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.get(url, headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  // =========================
  // POST (LOGIN COOKIE CAPTURE)
  // =========================
  static Future<dynamic> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode(body),
    );

    // 🍪 CAPTURE COOKIE
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      cookie = rawCookie.split(';').first;
      print("🍪 COOKIE SAVED: $cookie");

      await saveCookie(cookie!); // 🔥 persist permanently
    }

    return _handleResponse(response);
  }

  // =========================
  // PUT
  // =========================
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

  // =========================
  // DELETE
  // =========================
  static Future<dynamic> deleteRequest(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    try {
      final response = await http.delete(url, headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception("DELETE request failed: $e");
    }
  }

  // =========================
  // RESPONSE HANDLER
  // =========================
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
            "Error: ${response.statusCode} ${response.body}");
    }
  }

  // =========================
  // TRANSACTIONS API
  // =========================
  static Future<List<TranscationModel>> getTranscations() async {
    final response = await getRequest("/payments/transactions");

    List data = [];

    if (response is List) {
      data = response;
    } else if (response['transactions'] != null) {
      data = response['transactions'];
    } else if (response['data'] != null) {
      data = response['data'];
    }

    return data.map((e) => TranscationModel.fromJson(e)).toList();
  }
}
