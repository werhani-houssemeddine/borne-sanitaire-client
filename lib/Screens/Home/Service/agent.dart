import 'dart:convert';

import 'package:borne_sanitaire_client/Screens/Home/interface/agent_inerface.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:http/http.dart' as http;

class AgentListServerResponse {
  final GET_ALL_AGENT_INTERFACE status;
  final dynamic data;

  AgentListServerResponse({required this.status, this.data});
}

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

  static Future<AgentListServerResponse> getAllAgents() async {
    const String endpoint = "/api/client/agent/all/";

    try {
      var response = await SecureRequest.get(endpoint: endpoint);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        bool error = responseData["error"];
        String state = responseData["state"];
        if (error == false && state == "success") {
          var data = responseData["data"];
          if (data is List) {
            return AgentListServerResponse(
              status: GET_ALL_AGENT_INTERFACE.SUCCESS,
              data: data.isEmpty
                  ? []
                  : data.map((e) => Map.from(e).remove('agent_id')),
            );
          }
        }
      }

      return AgentListServerResponse(
        status: GET_ALL_AGENT_INTERFACE.BAD_REQUEST,
        data: null,
      );
    } catch (e) {
      return AgentListServerResponse(
        status: GET_ALL_AGENT_INTERFACE.SERVER_ERROR,
        data: null,
      );
    }
  }
}
