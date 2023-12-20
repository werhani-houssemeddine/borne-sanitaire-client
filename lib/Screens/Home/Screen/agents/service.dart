import 'dart:convert';
import 'package:borne_sanitaire_client/Service/request.dart';
import 'package:borne_sanitaire_client/Screens/Home/interface/agent_inerface.dart';
import 'package:borne_sanitaire_client/data/agent.dart';
import 'package:http/http.dart' as http;

class AgentListServerResponse {
  final GET_ALL_AGENT_INTERFACE status;
  final List<Agent>? data;

  AgentListServerResponse({required this.status, this.data});
}

class AgentService {
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
                  : data.map((e) => Agent.makeAgent(e)).toList(),
            );
          } else {
            return AgentListServerResponse(
              status: GET_ALL_AGENT_INTERFACE.SUCCESS,
              data: [],
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

  static Future getOneAgent(int agentId) async {
    try {
      var response =
          await SecureRequest.get(endpoint: '/api/client/agent/one/$agentId/');

      var permessionsResponse = await SecureRequest.get(
          endpoint: 'api/client/agent/permession/get/$agentId/');

      bool agentResponseStatus =
          response.statusCode >= 200 && response.statusCode <= 299;
      bool permessionResponseStatus = permessionsResponse.statusCode >= 200 &&
          permessionsResponse.statusCode <= 299;

      if (agentResponseStatus && permessionResponseStatus) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        Map<String, dynamic> responseBodyPerm =
            jsonDecode(permessionsResponse.body);

        if (responseBody.containsKey('data')) {
          if (responseBodyPerm.containsKey('data')) {
            Map<String, dynamic> data = responseBody['data'];
            Map<String, dynamic> dataPerm = responseBodyPerm['data'];

            return {
              "email": data["agent_email"],
              "user_name": data["user_name"],
              "active": data["active"],
              "profile_picture": data["profile_picture"],
              "phone_number": data["phone_number"],
              "created_at": data["created_at"],
              "permessions": dataPerm["listOfPermessions"],
              "manage_devices": dataPerm["manage_devices"],
              "manage_agents": dataPerm["manage_agents"],
            };
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
