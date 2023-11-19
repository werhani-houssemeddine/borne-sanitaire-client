import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:borne_sanitaire_client/config.dart' show BASE_URL;

Uri _makeURI({required String endpoint, Map<String, String>? queries}) {
  return Uri.http(BASE_URL, endpoint, queries);
}

class Request {
  static get(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, String>? queries}) async {
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
