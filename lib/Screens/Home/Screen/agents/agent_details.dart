// ignore_for_file: non_constant_identifier_names

import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/agent_links.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/agent_profile.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/permessions.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:borne_sanitaire_client/utils/convert_date.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class AgentDetailsModal extends StatelessWidget {
  final int agentId;
  const AgentDetailsModal({Key? key, required this.agentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: AgentService.getOneAgent(agentId),
        builder: (context, snapshoot) {
          if (snapshoot.data != null) {
            bool isActif = snapshoot.data['active'] == true;
            String email = snapshoot.data['email'];
            String username = snapshoot.data['user_name'];
            String createdAt = formatDateTime(snapshoot.data['created_at']);
            return Container(
              height: size.height,
              width: size.width,
              color: AppColors.bgColor,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const ArrowBack(),
                  const Divider(),
                  AgentDetailsProfileSection(
                    email: email,
                    username: username,
                    createdAt: createdAt,
                    profilePicture: snapshoot.data['profile_picture'],
                    isActif: isActif,
                  ),
                  AgentDetailsLinkSection(agentId: agentId, isActif: isActif),
                  const Divider(),
                  AgentPermessions(
                    manage_devices: snapshoot.data["manage_devices"],
                    manage_agents: snapshoot.data["manage_agents"],
                    permessions: snapshoot.data["permessions"],
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
  }
}
