import 'dart:convert';
import 'dart:io';
import 'package:borne_sanitaire_client/utils/hive.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types, constant_identifier_names
enum INITIALIZATION_RESPONSE { LOGIN, ERROR, HOME }

class AuthManager {
  static Future<INITIALIZATION_RESPONSE> initialize() async {
    try {
      String? token = await _getToken();
      if (token != null) {
        http.Response response = await _makeRequest(token);

        if (response.statusCode == HttpStatus.unauthorized) {
          return _handleFailureRequest();
        } else if (response.statusCode == HttpStatus.ok) {
          return _handleSuccessRequest(jsonDecode(response.body));
        }
        throw Exception('Unexpected status code: ${response.statusCode}');
      } else {
        return INITIALIZATION_RESPONSE.LOGIN;
      }
    } catch (e) {
      return INITIALIZATION_RESPONSE.ERROR;
    }
  }

  static Future<String?> _getToken() async {
    try {
      LocalStorageAuthToken.registerToken();
      String? token = await LocalStorageAuthToken.getToken();
      return token;
    } catch (e) {
      print('Error getting token: $e');
      rethrow;
    }
  }

  static Future<http.Response> _makeRequest(String? token) async {
    try {
      if (token == null) throw Exception('Token is null');

      const String endpoint = "/api/client/";
      Map<String, String> headers = {"Authorization": token};
      return await Request.get(endpoint: endpoint, headers: headers);
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }

  static INITIALIZATION_RESPONSE _handleSuccessRequest(
      Map<String, String> body) {
    return body['state'] == 'SUCCESS'
        ? INITIALIZATION_RESPONSE.HOME
        : INITIALIZATION_RESPONSE.LOGIN;
  }

  static INITIALIZATION_RESPONSE _handleFailureRequest() {
    LocalStorageAuthToken.deleteToken();
    return INITIALIZATION_RESPONSE.LOGIN;
  }
}
