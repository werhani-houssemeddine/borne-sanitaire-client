import 'package:http/http.dart' as http;

import 'package:borne_sanitaire_client/config.dart';

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

  static post() {}
}
