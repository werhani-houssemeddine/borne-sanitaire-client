// ignore_for_file: non_constant_identifier_names

class Agent {
  final int Id;
  final String email;
  final String username;
  final bool isActive;
  final int? phoneNumber;
  final String? profilePicture;
  final List permessions;

  Agent({
    required this.Id,
    required this.email,
    required this.username,
    required this.isActive,
    required this.permessions,
    required this.phoneNumber,
    required this.profilePicture,
  });

  static Agent makeAgent(Map<dynamic, dynamic> agent_dict) {
    if (agent_dict['agent_id'] == null ||
        agent_dict['agent_email'] == null ||
        agent_dict['user_name'] == null ||
        agent_dict['active'] == null ||
        agent_dict['permessions'] == null) {
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
    );
  }
}
