import 'package:borne_sanitaire_client/data/agent.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/show_image.dart';
import 'package:flutter/material.dart';

class AgentScreen2 extends StatelessWidget {
  final List<Agent> agents;
  const AgentScreen2({Key? key, required this.agents}) : super(key: key);

  _filterAgents() {
    List<Agent> listOfActifAgents = [];
    List<Agent> listOfSusspendedAgents = [];

    for (var agent in agents) {
      agent.isActive
          ? listOfActifAgents.add(agent)
          : listOfSusspendedAgents.add(agent);
    }

    return [listOfActifAgents, listOfSusspendedAgents];
  }

  List<Agent> get listOfActifAgents => _filterAgents()[0];
  List<Agent> get listOfSusspendedAgents => _filterAgents()[1];
  List<Agent> get listOfPendingAgents => [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (agents.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListOfAgentRow(
                title: "All Agents",
                listOfAgent: [...agents, ...agents, ...agents],
              ),
            ),
          if (listOfActifAgents.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListOfAgentRow(
                title: "Actif Agent",
                listOfAgent: listOfActifAgents,
              ),
            ),
          if (listOfPendingAgents.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListOfAgentRow(
                title: "Pending Agent",
                listOfAgent: listOfPendingAgents,
              ),
            ),
          if (listOfSusspendedAgents.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListOfAgentRow(
                title: "Suspend Agent",
                listOfAgent: listOfSusspendedAgents,
              ),
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
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listOfAgent != null ? showAgents() : [],
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(12.0),
        constraints: const BoxConstraints(
          maxWidth: 90,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowOnlineImage(
              size: const Size(60, 60),
              color: Colors.green,
              urlImage: profilePicture,
            ),
            Center(
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
            )
          ],
        ),
      ),
    );
  }
}
