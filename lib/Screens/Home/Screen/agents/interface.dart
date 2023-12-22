// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:borne_sanitaire_client/data/agent.dart';

enum ADD_AGENT_INTERFACE { SUCCESS, EMAIL_USED, MISSING_EMAIL, SERVER_ERROR }

enum GET_ALL_AGENT_INTERFACE { SUCCESS, EMPTY, BAD_REQUEST, SERVER_ERROR }

abstract class ServerResponse<T, U> {
  final T status;
  final U? data;

  ServerResponse({required this.status, this.data});
}

class AgentListServerResponse
    extends ServerResponse<GET_ALL_AGENT_INTERFACE, List<Agent>?> {
  AgentListServerResponse({
    required GET_ALL_AGENT_INTERFACE status,
    List<Agent>? data,
  }) : super(status: status, data: data);
}

class PendingAgentServerResponse
    extends ServerResponse<GET_ALL_AGENT_INTERFACE, List<PendingAgent>?> {
  PendingAgentServerResponse({
    required GET_ALL_AGENT_INTERFACE status,
    List<PendingAgent>? data,
  }) : super(status: status, data: data);
}
