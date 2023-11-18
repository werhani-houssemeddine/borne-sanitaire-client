import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:http/http.dart' as http;

Future<CHECKING_DEVICE> checkDeviceID(String deviceId) async {
  Map<String, String> queries = {"device_id": deviceId};
  String endpoint = '/api/client/admin/check-device/';

  http.Response response =
      await Request.get(endpoint: endpoint, queries: queries);

  if (response.statusCode == 200) {
    return CHECKING_DEVICE.VALID_DEVICE;
  } else if (response.statusCode >= 400 && response.statusCode <= 499) {
    return CHECKING_DEVICE.EXIPRED_DEVICE;
  }

  return CHECKING_DEVICE.INTERNAL_SERVER_ERROR;
}

// ignore: camel_case_types, constant_identifier_names
enum CHECKING_DEVICE { VALID_DEVICE, EXIPRED_DEVICE, INTERNAL_SERVER_ERROR }
