import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/agent.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types, constant_identifier_names
enum CURRENT_AGNT_SCREEN { ALL, PENDING, ACTIF, ARCHEIVED }

@RoutePage()
class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  _AgentsScreen createState() => _AgentsScreen();
}

class _AgentsScreen extends State<AgentsScreen> {
  late CURRENT_AGNT_SCREEN currentScreen;

  @override
  void initState() {
    currentScreen = CURRENT_AGNT_SCREEN.ALL;
    super.initState();
  }

  // setState(() {});
  void changeCurrentPage(CURRENT_AGNT_SCREEN newCurrentScreen) {
    if (newCurrentScreen != currentScreen) {
      setState(() {
        currentScreen = newCurrentScreen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Hello $currentScreen");
    return FutureBuilder(
      future: Agent.getAllAgents(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const AgentSearchBar(),
              FilterAgent(
                setCurrentScreenPage: changeCurrentPage,
              ),
              const ListOfAgent(),
            ],
          ),
        );
      },
    );
  }
}

class AgentSearchBar extends StatelessWidget {
  const AgentSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.black45,
          width: 1.0,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterAgent extends StatelessWidget {
  final void Function(CURRENT_AGNT_SCREEN) setCurrentScreenPage;
  const FilterAgent({
    Key? key,
    required this.setCurrentScreenPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            FilterAgentButton(
              filterText: "All",
              currentScreen: CURRENT_AGNT_SCREEN.ALL,
              setCurrentScreenPage: setCurrentScreenPage,
            ),
            FilterAgentButton(
              filterText: "Actif",
              currentScreen: CURRENT_AGNT_SCREEN.ACTIF,
              setCurrentScreenPage: setCurrentScreenPage,
            ),
            FilterAgentButton(
              filterText: "Pending",
              currentScreen: CURRENT_AGNT_SCREEN.PENDING,
              setCurrentScreenPage: setCurrentScreenPage,
            ),
            FilterAgentButton(
              filterText: "Archive",
              currentScreen: CURRENT_AGNT_SCREEN.ARCHEIVED,
              setCurrentScreenPage: setCurrentScreenPage,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterAgentButton extends StatelessWidget {
  final String filterText;
  final CURRENT_AGNT_SCREEN currentScreen;
  final void Function(CURRENT_AGNT_SCREEN) setCurrentScreenPage;

  const FilterAgentButton({
    Key? key,
    required this.filterText,
    required this.currentScreen,
    required this.setCurrentScreenPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setCurrentScreenPage(currentScreen);
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 25,
            maxHeight: 30,
            minWidth: 80,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue.shade50,
          ),
          child: Center(
            child: Text(
              filterText,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class ListOfAgent extends StatelessWidget {
  const ListOfAgent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.maxFinite,
        child: ListView(
          children: const [
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
            AgentData(),
          ],
        ),
      ),
    );
  }
}

class AgentData extends StatelessWidget {
  const AgentData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Profile Picture
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.indigo.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
