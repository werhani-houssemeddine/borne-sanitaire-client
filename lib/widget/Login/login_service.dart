import 'dart:convert';

import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:borne_sanitaire_client/widget/Login/interfaces.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

Future<LOGIN_RESPONSE> submitLoginForm(
    {required String email, required String password}) async {
  // Trim email and password
  email = email.trim();
  password = password.trim();

  // Create Payload
  Map<String, String> payload = {'email': email, 'password': password};

  String url = "/api/client/login/";
  http.Response response = await Request.post(endpoint: url, payload: payload);

  // Extract response body
  var responseBody = jsonDecode(response.body);

  // Return result
  if (response.statusCode == 401) {
    return LOGIN_RESPONSE.INCORRECT_CREDENTIALS;
  } else if (response.statusCode >= 500) {
    return LOGIN_RESPONSE.SERVER_ERROR;
  } else if (responseBody["state"] == "SUCCESS") {
    Map<String, String> data = responseBody["data"];
    if (data.containsKey('token')) {
      // Open authToken [HiveBox]
      final Box authBox = await Hive.openBox<AuthToken>('authBox');

      // Create an authToken instance
      final AuthToken makeToken = AuthToken(
        token: data['token'] as String,
        expiresIn: 3600,
      );

      // save the authToken instance
      await authBox.put('token', makeToken);

      // Close the box
      await Hive.close();

      return LOGIN_RESPONSE.SUCCESS;
    } else {
      return LOGIN_RESPONSE.SERVER_ERROR;
    }
  } else {
    return LOGIN_RESPONSE.BAD_INPUTS;
  }
}
