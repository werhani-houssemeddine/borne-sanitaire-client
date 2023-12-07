import 'dart:io';
import 'package:borne_sanitaire_client/Screens/complete_signup/interface.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:http/http.dart' as http;

import 'package:borne_sanitaire_client/Screens/services/update_client.dart';

Future? getCurrentDevice() {
  return null;
}

Future<COMPLETE_SIGN_UP_RESPONSE> handleSubmit({
  File? image,
  String? phone,
  String? maxVisitors,
  String? deviceId,
}) async {
  try {
    if (phone != null) {
      //? Check if the phone number is valid to use
      final String endpoint = '/api/client/check-phone/$phone';

      http.Response checkPhoneNumberResponse = await SecureRequest.get(
        endpoint: endpoint,
      );

      int statusCode = checkPhoneNumberResponse.statusCode;

      if (statusCode == 404) {
        return COMPLETE_SIGN_UP_RESPONSE.USED_PHONE_NUMBER;
      } else if (statusCode == 400) {
        return COMPLETE_SIGN_UP_RESPONSE.INVALID_PHONE_NUMBER;
      } else if (statusCode >= 400 && statusCode <= 499) {
        return COMPLETE_SIGN_UP_RESPONSE.ERROR;
      }
    }
    if (image != null) {
      dynamic updateProfilePictureResponse = await updateProfilePhoto(image);

      int statusCode = updateProfilePictureResponse.statusCode;

      if (statusCode <= 199 || statusCode >= 300) {
        return COMPLETE_SIGN_UP_RESPONSE.PROFILE_PICTURE_ERROR;
      }
    }
    if (phone != null) {
      http.Response updatePhoneNumberResponse = await updatePhoneNumber(phone);
      int statusCode = updatePhoneNumberResponse.statusCode;

      if (statusCode >= 300 || statusCode <= 199) {
        return COMPLETE_SIGN_UP_RESPONSE.USED_PHONE_NUMBER;
      }
    }
    if (deviceId != null && maxVisitors != null) {
      print("Device $deviceId");
      http.Response setMaxVisitorNumber =
          await setMaxVisitors(maxVisitors, deviceId);

      int statusCode = setMaxVisitorNumber.statusCode;
      if (statusCode >= 300 || statusCode <= 199) {
        return COMPLETE_SIGN_UP_RESPONSE.ERROR;
      }
    }

    return COMPLETE_SIGN_UP_RESPONSE.SUCCESS;
  } catch (e) {
    print(e);
    return COMPLETE_SIGN_UP_RESPONSE.ERROR;
  }
}

void handleUpdatingPhoneNumber() {}
