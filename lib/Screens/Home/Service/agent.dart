import 'dart:convert';

import 'package:borne_sanitaire_client/Screens/Home/interface/agent_inerface.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:http/http.dart' as http;

class Agent {
  static Future<ADD_AGENT_INTERFACE> addAgent(String agentEmail) async {
    try {
      Map<String, String> payload = {"email": agentEmail};

      http.Response response = await SecureRequest.post(
          endpoint: '/api/client/admin/add-agent/', payload: payload);

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return ADD_AGENT_INTERFACE.SUCCESS;
      } else if (response.statusCode == 400) {
        if (responseBody['data']['details'] == "EMAIL IS ALREADY USED") {
          return ADD_AGENT_INTERFACE.EMAIL_USED;
        }
        return ADD_AGENT_INTERFACE.MISSING_EMAIL;
      }
      throw Exception();
    } catch (e) {
      return ADD_AGENT_INTERFACE.SERVER_ERROR;
    }
  }
}
