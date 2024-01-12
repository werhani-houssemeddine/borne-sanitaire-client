import 'dart:convert';

import 'package:borne_sanitaire_client/Screens/profile/settings/interface.dart';
import 'package:borne_sanitaire_client/Service/request.dart';

class SettingsService {
  static Future<CHECK_OTP_RESPONSE> checkOTP() async {
    String endpoint = "/api/client/authenticate/checkOTP";

    try {
      final response = await SecureRequest.get(endpoint: endpoint);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody.containsKey('data')) {
          final Map<String, dynamic> data = responseBody['data'];

          return data['otp_enabled'] == true
              ? CHECK_OTP_RESPONSE.ENABLED
              : CHECK_OTP_RESPONSE.DISABLED;
        }
        return CHECK_OTP_RESPONSE.SERVER_ERROR;
      }
      return CHECK_OTP_RESPONSE.SERVER_ERROR;
    } catch (e) {
      return CHECK_OTP_RESPONSE.SERVER_ERROR;
    }
  }

  static Future<OTP_RESPONSE> _enableDisableOTP(
      String endpoint, String password) async {
    Map<String, String> payload = {'password': password};

    try {
      final response =
          await SecureRequest.post(endpoint: endpoint, payload: payload);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return OTP_RESPONSE.SUCCESS;
      } else if (response.statusCode == 400) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('data')) {
          final Map<String, dynamic> data = responseBody['data'];

          if (data.containsKey('password')) {
            final errorMessage = data['password'];
            print(errorMessage);
            if (errorMessage == 'wrong password') {
              return OTP_RESPONSE.WRONG_PASSWORD;
            } else if (errorMessage == 'missing password') {
              return OTP_RESPONSE.MISSING_PASSWORD;
            }
          }
        }
      }
      return OTP_RESPONSE.SERVER_ERROR;
    } catch (e) {
      return OTP_RESPONSE.SERVER_ERROR;
    }
  }

  static Future<OTP_RESPONSE> disableOTP(String password) async {
    String endpoint = "/api/client/authenticate/disableOTP/";
    return _enableDisableOTP(endpoint, password);
  }

  static Future<OTP_RESPONSE> enableOTP(String password) async {
    String endpoint = "/api/client/authenticate/enableOTP/";
    return _enableDisableOTP(endpoint, password);
  }

  static Future<void> deleteAccount(String password) async {
    String endpoint = "/api/client/authenticate/delete/account/";
    Map<String, String> payload = {'password': password};

    try {
      final response =
          await SecureRequest.delete(endpoint: endpoint, payload: payload);
      if (response.statusCode == 200) {
        print('Account deleted.');
      } else {
        print('Failed to delete account. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during account deletion: $e');
    }
  }
}
