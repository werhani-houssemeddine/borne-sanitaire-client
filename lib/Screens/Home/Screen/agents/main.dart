import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/agent_details.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:borne_sanitaire_client/config.dart';
import 'package:borne_sanitaire_client/data/agent.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/show_image.dart';
import 'package:flutter/material.dart';

class Agents {
  static Map<String, List<Agent>> getFiltredAgent(List<Agent> agents) {
    List<Agent> listOfActifAgents = [];
    List<Agent> listOfSusspendedAgents = [];

    for (var agent in agents) {
      agent.isActive
          ? listOfActifAgents.add(agent)
          : listOfSusspendedAgents.add(agent);
    }

    return {
      "actif": listOfActifAgents,
      "suspend": listOfSusspendedAgents,
    };
  }

  static List<Agent> listOfActifAgents(List<Agent> agents) =>
      getFiltredAgent(agents)["actif"]!;

  static List<Agent> listOfSusspendedAgents(List<Agent> agents) =>
      getFiltredAgent(agents)["suspend"]!;

  static List<Agent> get listOfPendingAgents => [];
}

@RoutePage()
class AgentsScreen extends StatelessWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AgentService.getAllAgents(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Agent> agents = snapshot.data.data;

          return AgentWidgets(
            agents: agents,
            listOfActifAgents: Agents.listOfActifAgents(agents),
            listOfPendingAgents: Agents.listOfPendingAgents,
            listOfSusspendedAgents: Agents.listOfSusspendedAgents(agents),
          );
        }
        //? If getAllAgents request is not success
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}

class AgentWidgets extends StatelessWidget {
  const AgentWidgets({
    super.key,
    required this.agents,
    required this.listOfActifAgents,
    required this.listOfPendingAgents,
    required this.listOfSusspendedAgents,
  });

  final List<Agent> agents;
  final List<Agent> listOfActifAgents;
  final List<Agent> listOfPendingAgents;
  final List<Agent> listOfSusspendedAgents;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (agents.isEmpty) const Text("There is no agent add new ?"),
          if (agents.isNotEmpty)
            ListOfAgentRow(
              title: "All Agents",
              listOfAgent: agents,
            ),
          if (listOfActifAgents.isNotEmpty)
            ListOfAgentRow(
              title: "Actif Agent",
              listOfAgent: listOfActifAgents,
            ),
          if (listOfPendingAgents.isNotEmpty)
            ListOfAgentRow(
              title: "Pending Agent",
              listOfAgent: listOfPendingAgents,
            ),
          if (listOfSusspendedAgents.isNotEmpty)
            ListOfAgentRow(
              title: "Suspend Agent",
              listOfAgent: listOfSusspendedAgents,
            ),
        ],
      ),
    );
  }
}

class ListOfAgentRow extends StatelessWidget {
  final String title;
  final List<Agent>? listOfAgent;

  const ListOfAgentRow({
    super.key,
    required this.title,
    this.listOfAgent,
  });

  List<Widget> showAgents() {
    return listOfAgent!
        .map((e) => AgentWidget(
              username: e.username,
              profilePicture: e.profilePicture,
              id: e.Id,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MakeGestureDetector(
            onPressed: () {
              print("Clicked $title");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: listOfAgent != null ? showAgents() : [],
            ),
          ),
        ],
      ),
    );
  }
}

class AgentWidget extends StatelessWidget {
  final String? profilePicture;
  final String username;
  final int id;

  const AgentWidget({
    super.key,
    required this.profilePicture,
    required this.username,
    required this.id,
  });

  Widget get imageWidget => ShowImage(
        size: const Size(60, 60),
        defaultAssets: 'assets/user.png',
        onlinePictureSrc: profilePicture,
        padding: 5,
      );

  Widget get usernameWidget => Center(
        child: Text(
          username,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 10,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () {
        ShowModalContainer(
          context,
          child: AgentDetailsModal(agentId: id),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        constraints: const BoxConstraints(
          maxWidth: 90,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [imageWidget, usernameWidget],
        ),
      ),
    );
  }
}
