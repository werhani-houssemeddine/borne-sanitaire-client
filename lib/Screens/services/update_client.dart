import 'dart:convert';
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

Future<bool> updateUsername(String username) async {
  const String endpoint = "/api/client/update/username/";
  try {
    final http.Response response = await SecureRequest.put(
      endpoint: endpoint,
      payload: {'username': username},
    );

    return response.statusCode >= 200 && response.statusCode <= 299;
  } catch (e) {
    rethrow;
  }
}

Future<String?> updatePhone(String phone) async {
  const String endpoint = "/api/client/update/phone-number/";
  try {
    final http.Response response = await SecureRequest.put(
      endpoint: endpoint,
      payload: {'phone_number': phone},
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return null;
    }

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody.containsKey('data')) {
      Map<String, dynamic> data = responseBody['data'];
      if (data.containsKey('phone_number') &&
          data['phone_number'] == 'Already used') {
        return 'This phone number is already used';
      }
    }

    return null;
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
