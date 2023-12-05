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
                currentScreen: currentScreen,
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
  final CURRENT_AGNT_SCREEN currentScreen;
  const FilterAgent({
    Key? key,
    required this.setCurrentScreenPage,
    required this.currentScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blue.shade100,
      ),
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
              isItCurrentScreen: currentScreen == CURRENT_AGNT_SCREEN.ALL,
            ),
            FilterAgentButton(
              filterText: "Actif",
              currentScreen: CURRENT_AGNT_SCREEN.ACTIF,
              setCurrentScreenPage: setCurrentScreenPage,
              isItCurrentScreen: currentScreen == CURRENT_AGNT_SCREEN.ACTIF,
            ),
            FilterAgentButton(
              filterText: "Pending",
              currentScreen: CURRENT_AGNT_SCREEN.PENDING,
              setCurrentScreenPage: setCurrentScreenPage,
              isItCurrentScreen: currentScreen == CURRENT_AGNT_SCREEN.PENDING,
            ),
            FilterAgentButton(
              filterText: "Archive",
              currentScreen: CURRENT_AGNT_SCREEN.ARCHEIVED,
              setCurrentScreenPage: setCurrentScreenPage,
              isItCurrentScreen: currentScreen == CURRENT_AGNT_SCREEN.ARCHEIVED,
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
  final bool isItCurrentScreen;

  final void Function(CURRENT_AGNT_SCREEN) setCurrentScreenPage;

  const FilterAgentButton({
    Key? key,
    required this.filterText,
    required this.currentScreen,
    required this.setCurrentScreenPage,
    required this.isItCurrentScreen,
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
            minHeight: 20,
            maxHeight: 30,
            minWidth: 80,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:
                isItCurrentScreen ? Colors.indigo.shade800 : Colors.transparent,
          ),
          child: Center(
            child: Text(
              filterText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: isItCurrentScreen ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListOfAgent extends StatelessWidget {
  const ListOfAgent({Key? key}) : super(key: key);

  TableCell addMarginToTableCell(Widget child) {
    return TableCell(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: child,
      ),
    );
  }

  Widget profilePhotoCell() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.red,
      ),
    );
  }

  Text agentNameCell({String? name}) {
    return Text(
      name ?? 'Werhani Houssemeddine',
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
      ),
    );
  }

  Widget stateAgentCell() {
    return const Text(
      'Active',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }

  TableRow makeAgentRow({String? name}) {
    return TableRow(
      children: [
        addMarginToTableCell(profilePhotoCell()),
        addMarginToTableCell(agentNameCell(name: name)),
        addMarginToTableCell(stateAgentCell()),
        // editIconCell(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FixedColumnWidth(40),
        1: IntrinsicColumnWidth(flex: 1),
        2: IntrinsicColumnWidth(),
        // 3: FixedColumnWidth(40)
      },
      children: [
        makeAgentRow(),
        makeAgentRow(),
        makeAgentRow(),
        makeAgentRow(name: 'Iyed Tizaoui'),
      ],
    );

    /*Expanded(
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
    );*/
  }
}
