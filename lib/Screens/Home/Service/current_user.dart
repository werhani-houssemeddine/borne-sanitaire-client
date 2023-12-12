import 'dart:convert';

import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/utils/hive.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:http/http.dart' as http;

class ExtractRequestData {
  String bodyResponse;
  ExtractRequestData({required this.bodyResponse});

  Map? _getBodyPayload() {
    try {
      Map<String, dynamic> decodedBodyResponse = jsonDecode(bodyResponse);
      if (decodedBodyResponse.containsKey('data')) {
        Map<String, dynamic> userData = decodedBodyResponse['data'];

        userData['user']['id'] = userData['id'];
        return userData['user'];
      }

      throw Exception("Missing data from server response");
    } catch (e) {
      return null;
    }
  }
}

class User {
  static Future getCurrentUserData({bool update = false}) async {
    try {
      String token = await getTokenFromLocalStorage();
      // print("TOKEN FROM LOCAL STORAGE $token");
      http.Response response = await _makeRequest(token);

      var data = ExtractRequestData(bodyResponse: response.body);
      var user = data._getBodyPayload();

      int id = user?['id'];
      String email = user?['email'];
      String username = user?['username'];
      String role = user?['role'];
      int? phoneNumber = user?['phone_number'];
      String? profilePicture = user?['profile_picture'];

      if (update && CurrentUser.haveInstance) {
        print('Hello World');
        return CurrentUser.updateInstance(
          email: email,
          username: username,
          id: id,
          role: role,
          profilePicture: profilePicture,
          phoneNumber: phoneNumber,
          token: token,
        );
      } else {
        return CurrentUser.createInstance(
          email: email,
          username: username,
          id: id,
          role: role,
          profilePicture: profilePicture,
          phoneNumber: phoneNumber,
          token: token,
        );
      }
    } catch (e) {
      print("AN EXCEPTION OCCURED $e");
      throw Exception();
    }
  }

  static Future<http.Response> _makeRequest(String? token) async {
    try {
      print('apppearrr');
      if (token == null) throw Exception();

      const String endpoint = "/api/client/";
      Map<String, String> headers = {"Authorization": token};
      return await Request.get(endpoint: endpoint, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getTokenFromLocalStorage() async {
    try {
      String? token = await LocalStorageAuthToken.getToken();
      if (token != null) return token;

      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
