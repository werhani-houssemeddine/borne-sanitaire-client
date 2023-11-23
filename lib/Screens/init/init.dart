import 'dart:convert';
import 'package:borne_sanitaire_client/utils/hive.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types, constant_identifier_names
enum INITIALIZATION_RESPONSE { LOGIN, ERROR, HOME }

class AuthManager {
  static Future<INITIALIZATION_RESPONSE> initialize() async {
    try {
      String? token = await _getToken();
      http.Response response = await _makeRequest(token);

      if (response.statusCode == 401) {
        return _handleFailureRequest();
      } else if (response.statusCode == 200) {
        return _handleSuccessRequest(jsonDecode(response.body));
      }

      throw Exception();
    } catch (e) {
      return INITIALIZATION_RESPONSE.ERROR;
    }
  }

  static Future<String?> _getToken() async {
    try {
      LocalStorageAuthToken.registerToken();
      String? token = await LocalStorageAuthToken.getToken();

      if (token != null) return token;
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> _makeRequest(String? token) async {
    try {
      if (token == null) throw Exception();

      const String endpoint = "/api/client/current-user/";
      Map<String, String> headers = {"Authorization": token};
      return await Request.get(endpoint: endpoint, headers: headers);
    } catch (e) {
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
