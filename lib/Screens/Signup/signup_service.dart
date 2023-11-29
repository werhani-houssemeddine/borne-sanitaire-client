import 'dart:convert';

import 'package:borne_sanitaire_client/Screens/Signup/response_service.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/models/auth_token.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

Future<CHECKING_DEVICE> checkDeviceID(String deviceId) async {
  try {
    Map<String, String> queries = {"device_id": deviceId};
    String endpoint = '/api/client/device/check-device/';

    http.Response response =
        await Request.get(endpoint: endpoint, queries: queries);
    if (response.statusCode == 200) {
      return CHECKING_DEVICE.VALID_DEVICE;
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      return CHECKING_DEVICE.EXIPRED_DEVICE;
    }

    return CHECKING_DEVICE.INTERNAL_SERVER_ERROR;
  } on http.ClientException catch (clientException) {
    print("CLIENT Exception $clientException");
    return CHECKING_DEVICE.INTERNAL_SERVER_ERROR;
  } catch (e) {
    print('Error in checkDeviceID: $e');
    return CHECKING_DEVICE.INTERNAL_SERVER_ERROR;
  }
}

Future<SIGN_UP_RESULT> makeSignUpRequest({
  required String email,
  required String username,
  required String password,
  required String deviceId,
}) async {
  try {
    http.Response response = await Request.post(
      endpoint: '/api/client/signup/',
      payload: {
        'email': email,
        'user_name': username,
        'password': password,
      },
      queries: {
        'device': deviceId,
      },
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      dynamic data = responseBody['data'];
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
        return SIGN_UP_RESULT.SUCCESS;
      }
    } else if (response.statusCode == 400) {
      if (responseBody['error'] == true) {
        //? Get error details on problem is email in use
        //? it not following the pattern as missing one property
        //? also malforamatted properties also
        final errorDetails = responseBody['data']['details'];

        //? when email is used the response is { 'email': 'this ...' }
        //? not the same pattern
        if (errorDetails == null) {
          return SIGN_UP_RESULT.BAD_REQUEST_EMAIL_USED;
        }

        //? Creating a map of possible error
        final Map<String, SIGN_UP_RESULT> errorMap = {
          "Email IS REQUIRED": SIGN_UP_RESULT.BAD_REQUEST_MISSING_EMAIL,
          "PASSWORD IS REQUIRED": SIGN_UP_RESULT.BAD_REQUEST_MISSING_PASSWORD,
          "USER_NAME IS REQUIRED": SIGN_UP_RESULT.BAD_REQUEST_MISSING_USERNAME,
        };

        return errorMap[errorDetails] ?? SIGN_UP_RESULT.FAILURE;
      }
    }

    return SIGN_UP_RESULT.FAILURE;
  } catch (error) {
    //? Server Error
    return SIGN_UP_RESULT.SERVER_ERROR;
  }
}
