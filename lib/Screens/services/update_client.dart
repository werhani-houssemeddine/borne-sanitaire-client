import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:borne_sanitaire_client/Service/request.dart';

Future updateProfilePhoto(File image) async {
  return await upload(image);
}

Future<http.Response> updatePhoneNumber(String phone) async {
  const String endpoint = "/api/client/update/phone-number/";
  try {
    return SecureRequest.put(
      endpoint: endpoint,
      payload: {'phone_number': phone},
    );
  } catch (e) {
    rethrow;
  }
}

Future<http.Response> setMaxVisitors(
    String visitorNumber, String deviceId) async {
  final String endpoint = "/api/client/device/visitor/$deviceId";
  try {
    return SecureRequest.put(
      endpoint: endpoint,
      payload: {'max_visitors': visitorNumber},
    );
  } catch (e) {
    rethrow;
  }
}
