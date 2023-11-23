// Check if the user logged In to redirect him to
// Main Page otherwise he will be redirect to Login Page

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:borne_sanitaire_client/models/auth_token.dart';

import 'package:borne_sanitaire_client/Service/request.dart';

import 'package:http/http.dart' as http;

Future<INITIALIZATION_RESPONSE> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(AuthTokenAdapter());

  try {
    final Box authBox = await Hive.openBox<AuthToken>('authBox');
    final AuthToken? isTokenExist = await authBox.get('token');

    if (isTokenExist != null) {
      String token = isTokenExist.token;

      const String endpoint = "/api/client/current-user/";
      Map<String, String> headers = {"Authorization": token};

      http.Response response =
          await Request.get(endpoint: endpoint, headers: headers);

      //? Must redirect to Login Page and delete the token from authBox
      if (response.statusCode == 401) {
        //? delete token from authBox
        await authBox.delete('token');
        return INITIALIZATION_RESPONSE.LOGIN;
      } else if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var state = body['state'];
        if (state == "SUCCESS") {
          return INITIALIZATION_RESPONSE.HOME;
        } else {
          return INITIALIZATION_RESPONSE.LOGIN;
        }
      }

      return INITIALIZATION_RESPONSE.LOGIN;
    } else {
      return INITIALIZATION_RESPONSE.LOGIN;
    }
  } catch (_) {
    return INITIALIZATION_RESPONSE.ERROR;
  }
}

// ignore_for_file: constant_identifier_names
// ignore: camel_case_types
enum INITIALIZATION_RESPONSE { LOGIN, ERROR, HOME }
