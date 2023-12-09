import 'package:borne_sanitaire_client/Service/request.dart';

Future addNewDevice(String deviceId) async {
  String endpoint = "/api/client/device/new/";
  return SecureRequest.post(
      endpoint: endpoint, payload: {'device_id': deviceId});
}
