import 'dart:convert';
import 'dart:io';

import 'package:borne_sanitaire_client/Screens/Home/Service/real_time.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/config.dart';
import 'package:borne_sanitaire_client/data/device.dart';
import 'package:http/http.dart' as http;

Future addNewDevice(String deviceId) async {
  String endpoint = "/api/client/device/new/";
  return SecureRequest.post(
      endpoint: endpoint, payload: {'device_id': deviceId});
}

Future<List<Device>?> getAllDevices() async {
  try {
    String endpoint = "/api/client/device/all/";
    http.Response response = await SecureRequest.get(endpoint: endpoint);
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      Map<String, dynamic> body = jsonDecode(response.body);
      if (body.containsKey("data")) {
        List<dynamic> data = body['data'];
        List<Device> listOfDevices = [];
        for (Map<String, dynamic> element in data) {
          listOfDevices.add(Device.createDeviceInstance(element));
        }
        return listOfDevices;
      }
    }
    return null;
  } on Exception catch (e) {
    return null;
  }
}

Future<SocketManager> initSocket(String deviceId) async {
  final socketManager = SocketManager();

  await socketManager.initConnection(
    '$SERVER_REAL_TIME/device',
    {'device_id': deviceId},
  );

  return socketManager;
}

Future initialDataToDahsboard() async {
  var listOfDevices = await getAllDevices();

  return listOfDevices;
}
