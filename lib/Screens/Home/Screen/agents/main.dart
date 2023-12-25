import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/agent_details.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/interface.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/data/agent.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/show_bottom_modal.dart';
import 'package:borne_sanitaire_client/widget/show_image.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

class Agents {
  static Future<Map<String, List>> init() async {
    List<Agent>? agents = await Agents.getAgents();
    List<PendingAgent>? pendingAgents = await Agents.getPendingAgents();

    return {
      "agents": agents ?? [],
      "pendingAgents": pendingAgents ?? [],
    };
  }

  static Future<List<Agent>?> getAgents() async {
    AgentListServerResponse agentServiceResponse =
        await AgentService.getAllAgents();

    return agentServiceResponse.status == GET_ALL_AGENT_INTERFACE.SUCCESS
        ? agentServiceResponse.data
        : null;
  }

  static Future<List<PendingAgent>?> getPendingAgents() async {
    PendingAgentServerResponse pendingAgentServiceResponse =
        await RequestAgentService.getAllRequestAgent();

    return pendingAgentServiceResponse.status == GET_ALL_AGENT_INTERFACE.SUCCESS
        ? pendingAgentServiceResponse.data
        : null;
  }

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
}

@RoutePage()
class AgentsScreen extends StatelessWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Agents.init(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("snapshot ${snapshot.data}");
          List<Agent> agents = snapshot.data['agents'];
          List<PendingAgent> pendingAgents = snapshot.data['pendingAgents'];

          return AgentWidgets(
            agents: agents,
            listOfActifAgents: Agents.listOfActifAgents(agents),
            listOfPendingAgents: pendingAgents,
            listOfSusspendedAgents: Agents.listOfSusspendedAgents(agents),
          );
        }

        //? If getAllAgents request is not success
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}

class NoAgentWidget extends StatelessWidget {
  const NoAgentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            "There is no agent add new ?",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
        MakeGestureDetector(
          child: Container(
            width: double.maxFinite - 20,
            margin: const EdgeInsets.all(20),
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "New Agent",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          onPressed: () => AddAgentBuilder(context),
        ),
      ],
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
  final List<PendingAgent> listOfPendingAgents;
  final List<Agent> listOfSusspendedAgents;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (agents.isEmpty) const NoAgentWidget(),
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
              listOfPendingAgents: listOfPendingAgents,
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
  final List<PendingAgent>? listOfPendingAgents;

  const ListOfAgentRow({
    super.key,
    required this.title,
    this.listOfAgent,
    this.listOfPendingAgents,
  });

  List<Widget> get showAgents {
    if (listOfAgent == null || listOfAgent!.isEmpty) return [];

    return listOfAgent!
        .map((e) => AgentWidget(
              username: e.username,
              profilePicture: e.profilePicture,
              id: e.Id,
              isAgent: true,
            ))
        .toList();
  }

  List<Widget> get showPendingAgents {
    if (listOfPendingAgents == null || listOfPendingAgents!.isEmpty) return [];

    return listOfPendingAgents!
        .map((e) => AgentWidget(
              username: e.email,
              id: e.Id,
              isAgent: false,
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
          const Divider(),
          MakeGestureDetector(
            onPressed: () {
              print("Clicked $title");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
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
              children: [...showAgents, ...showPendingAgents],
            ),
          ),
        ],
      ),
    );
  }
}

class AgentWidget extends StatelessWidget {
  final String username;
  final String? profilePicture;
  final dynamic id;
  final bool isAgent;

  const AgentWidget({
    super.key,
    required this.username,
    required this.isAgent,
    this.id,
    this.profilePicture,
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
        ShowModalBttomSheet(
          context,
          child: isAgent
              ? AgentDetailsModal(agentId: id)
              : PendingAgentModal(Id: id),
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
