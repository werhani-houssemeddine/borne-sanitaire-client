// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:borne_sanitaire_client/data/agent.dart';

enum ADD_AGENT_INTERFACE { SUCCESS, EMAIL_USED, MISSING_EMAIL, SERVER_ERROR }

enum GET_ALL_AGENT_INTERFACE { SUCCESS, EMPTY, BAD_REQUEST, SERVER_ERROR }

class AgentListServerResponse {
  final GET_ALL_AGENT_INTERFACE status;
  final List<Agent>? data;

  AgentListServerResponse({required this.status, this.data});
}
