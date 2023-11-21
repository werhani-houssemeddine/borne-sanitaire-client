import 'dart:convert';

import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:borne_sanitaire_client/widget/Login/interfaces.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

Future<LOGIN_RESPONSE> submitLoginForm(
    {required String email, required String password}) async {
  try {
    Map<String, String> payload = _createPayload(email.trim(), password.trim());

    String url = "/api/client/login/";
    http.Response response = await _postRequest(url, payload);

    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 401) {
      throw LOGIN_RESPONSE.INCORRECT_CREDENTIALS;
    } else if (response.statusCode >= 500) {
      throw LOGIN_RESPONSE.SERVER_ERROR;
    } else {
      return _handleSuccessResponse(responseBody);
    }
  } catch (e) {
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
  if (responseBody["state"] == "SUCCESS") {
    Map<String, dynamic> data = responseBody["data"];
    print(data);
    if (data.containsKey('token')) {
      _saveAuthToken(data['token']!);
      return LOGIN_RESPONSE.SUCCESS;
    } else {
      return LOGIN_RESPONSE.SERVER_ERROR;
    }
  } else {
    return LOGIN_RESPONSE.BAD_INPUTS;
  }
}

void _saveAuthToken(String token) async {
  final Box authBox = await Hive.openBox<AuthToken>('authBox');
  final AuthToken makeToken = AuthToken(
    token: token,
    expiresIn: 3600,
  );
  await authBox.put('token', makeToken);
  await Hive.close();
}
