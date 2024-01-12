import 'dart:convert';

import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

Future<String?> compareSignupOTP(String code, String email) async {
  try {
    String endpoint = "api/client/authenticate/chekc-singup-code/";
    Map<String, String> payload = {
      'verification_code': code,
      'email': email,
    };

    http.Response response =
        await Request.post(endpoint: endpoint, payload: payload);

    if (response.statusCode == 200) return null;

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody.containsKey('data')) {
      print(responseBody);
      Map<String, dynamic> data = responseBody['data'];
      if (data.containsKey('email')) {
        return data['email'];
      }
    }
    throw Exception('Unknown Server, try again ');
  } on Exception catch (e) {
    return e.toString();
  }
}

Future<String?> compareLoginOTP(String code, String email) async {
  try {
    String endpoint = "api/client/authenticate/chekc-login-code/";
    Map<String, String> payload = {
      'verification_code': code,
      'email': email,
    };

    http.Response response =
        await Request.post(endpoint: endpoint, payload: payload);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('data')) {
        Map<String, dynamic> data = responseBody['data'];
        String? token = data['token'];

        if (token != null) _saveAuthToken(token);
        return null;
      }
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody.containsKey('data')) {
      Map<String, dynamic> data = responseBody['data'];
      if (data.containsKey('email')) {
        return data['email'];
      }
    }
    throw Exception('Unknown Server, try again ');
  } on Exception catch (e) {
    return e.toString();
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
