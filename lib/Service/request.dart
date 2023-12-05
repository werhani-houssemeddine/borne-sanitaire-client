import 'dart:convert';
import 'dart:io';

import 'package:borne_sanitaire_client/data/user.dart';
import 'package:http/http.dart' as http;

import 'package:borne_sanitaire_client/config.dart' show BASE_URL;

Uri _makeURI({required String endpoint, Map<String, String>? queries}) {
  return Uri.http(BASE_URL, endpoint, queries);
}

class Request {
  static get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queries,
  }) async {
    return await http.get(_makeURI(endpoint: endpoint, queries: queries),
        headers: headers);
  }

  static Future<http.Response> post({
    required String endpoint,
    required Map<String, String> payload,
    Map<String, String>? headers,
    Map<String, String>? queries,
  }) async {
    try {
      headers = {
        ...?headers,
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await http.post(
        _makeURI(endpoint: endpoint, queries: queries),
        body: jsonEncode(payload),
        headers: headers,
      );

      return response;
    } catch (error) {
      rethrow;
    }
  }
}

class SecureRequest {
  static Future<http.Response> post({
    required String endpoint,
    required Map<String, String> payload,
    Map<String, String>? headers,
    Map<String, String>? queries,
  }) async {
    try {
      if (CurrentUser.instance?.token == null) throw Exception();

      headers = {...?headers, "Authorization": CurrentUser.instance!.token};

      return await Request.post(
        endpoint: endpoint,
        payload: payload,
        headers: headers,
        queries: queries,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queries,
  }) async {
    if (CurrentUser.instance?.token == null) throw Exception();

    headers = {...?headers, "Authorization": CurrentUser.instance!.token};

    return await Request.get(endpoint: endpoint, headers: headers);
  }
}

upload(File imageFile) async {
  if (CurrentUser.instance?.token == null) throw Exception();

  var request = http.MultipartRequest(
    "POST",
    _makeURI(endpoint: '/api/client/update/profile-photo/'),
  );

  request.files.add(
    http.MultipartFile.fromBytes(
        'picture', File(imageFile.path).readAsBytesSync(),
        filename: imageFile.path),
  );

  request.headers.putIfAbsent(
    "Authorization",
    () => CurrentUser.instance!.token,
  );
  print("boom");
  return await request.send();
}
