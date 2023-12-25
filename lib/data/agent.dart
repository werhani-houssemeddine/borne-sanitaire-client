// ignore_for_file: non_constant_identifier_names

import 'package:borne_sanitaire_client/utils/convert_date.dart';

class Agent {
  final int Id;
  final String email;
  final String username;
  final bool isActive;
  final int? phoneNumber;
  final String? profilePicture;
  final List permessions;
  final String created_at;

  Agent({
    required this.Id,
    required this.email,
    required this.username,
    required this.isActive,
    required this.permessions,
    required this.phoneNumber,
    required this.profilePicture,
    required this.created_at,
  });

  static Agent makeAgent(Map<dynamic, dynamic> agent_dict) {
    if (agent_dict['agent_id'] == null ||
        agent_dict['agent_email'] == null ||
        agent_dict['user_name'] == null ||
        agent_dict['active'] == null ||
        agent_dict['permessions'] == null ||
        agent_dict['created_at'] == null) {
      throw ArgumentError('Invalid agent_dict. Missing required fields.');
    }

    return Agent(
      Id: agent_dict['agent_id'],
      email: agent_dict['agent_email'],
      username: agent_dict['user_name'],
      isActive: agent_dict['active'],
      phoneNumber: agent_dict['phone_number'],
      profilePicture: agent_dict['profile_picture'],
      permessions: List.from(agent_dict['permessions']),
      created_at: formatDateTime(agent_dict['created_at']),
    );
  }
}

class PendingAgent {
  final String Id;
  final String email;
  final String created_at;

  static List<PendingAgent> pendingAgents = [];

  PendingAgent({
    required this.Id,
    required this.email,
    required this.created_at,
  });

  static PendingAgent makePendingAgent(Map<dynamic, dynamic> p_agent_dict) {
    if (p_agent_dict['id'] == null ||
        p_agent_dict['agent_email'] == null ||
        p_agent_dict['created_at'] == null) {
      throw ArgumentError("Missing required field");
    }

    return PendingAgent(
      Id: p_agent_dict['id'],
      email: p_agent_dict['agent_email'],
      created_at: formatDateTime(p_agent_dict['created_at']),
    );
  }
}
