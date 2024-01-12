import 'dart:convert';

import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:borne_sanitaire_client/Screens/Login/interfaces.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

Future<LOGIN_RESPONSE> submitLoginForm(
    {required String email, required String password}) async {
  try {
    Map<String, String> payload = _createPayload(email.trim(), password.trim());
    String url = "/api/client/login/";
    http.Response response = await _postRequest(url, payload);
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody.containsKey('data')) {
      if (responseBody['data'].containsKey('verification code')) {
        return LOGIN_RESPONSE.REDIRECT_OTP;
      }
    }

    if (response.statusCode == 401) {
      return LOGIN_RESPONSE.INCORRECT_CREDENTIALS;
    } else if (response.statusCode >= 500) {
      throw LOGIN_RESPONSE.SERVER_ERROR;
    } else {
      if (responseBody.containsKey("state")) {
        String state = responseBody["state"];
        if (state.toUpperCase() == "SUCCESS") {
          return _handleSuccessResponse(responseBody['data']);
        }
        throw Exception("LOGIN WRONG STATE");
      }
      throw Exception("INVALID SERVER RESPONSE");
    }
  } catch (e) {
    print("An Exception occured function submitLoginForm $e");
    return LOGIN_RESPONSE.SERVER_ERROR;
  }
}

Future<http.Response> _postRequest(
    String url, Map<String, String> payload) async {
  return await Request.post(endpoint: url, payload: payload);
}

Map<String, String> _createPayload(String email, String password) {
  return {'email': email, 'password': password};
}

LOGIN_RESPONSE _handleSuccessResponse(Map<String, dynamic> responseBody) {
  print(responseBody);
  try {
    String? token = responseBody["token"];
    if (token != null) {
      _saveAuthToken(token);
      return LOGIN_RESPONSE.SUCCESS;
    } else {
      return LOGIN_RESPONSE.BAD_INPUTS;
    }
  } on Exception catch (e) {
    print("An error occurd function _handleSuccessResponse $e");
    rethrow;
  }
}

void _saveAuthToken(String token) async {
  final Box authBox = await Hive.openBox<AuthToken>('authBox');
  final AuthToken makeToken = AuthToken(
    token: token,
    expiresIn: 3600,
  );
  await authBox.put('token', makeToken);
  await authBox.close();
  await Hive.close();
}
