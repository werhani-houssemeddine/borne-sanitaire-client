// ignore_for_file: non_constant_identifier_names

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/permessions.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/show_image.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future ShowModalContainer(BuildContext context, {required Widget child}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(255, 241, 251, 255),
    barrierColor: Colors.black87.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) => child,
  );
}

class PendingAgentModal extends StatelessWidget {
  final String Id;
  const PendingAgentModal({Key? key, required this.Id}) : super(key: key);

  Widget makeButton({
    required void Function() onPressed,
    required String text,
    required Color color,
  }) {
    return MakeGestureDetector(
      onPressed: onPressed,
      child: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  void deletePendingAgent(BuildContext context) async {
    bool result = await RequestAgentService.deleteRequestAgent(Id);
    if (result) {
      if (context.mounted) {
        AutoRouter.of(context).popAndPush(const AgentsRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          makeButton(
            onPressed: () => deletePendingAgent(context),
            text: "delete",
            color: Colors.red,
          ),
          const Divider(),
          makeButton(
            onPressed: Navigator.of(context).pop,
            text: "cancel",
            color: Colors.black54,
          ),
          const Divider(),
        ],
      ),
    );
  }
}

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
                    email: snapshoot.data['email'],
                    username: snapshoot.data['user_name'],
                    createdAt: snapshoot.data['created_at'],
                    profilePicture: snapshoot.data['profile_picture'],
                  ),
                  const AgentDetailsLinkSection(),
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

class AgentDetailsProfileSection extends StatelessWidget {
  final String email;
  final String username;
  final String createdAt;
  final String? profilePicture;
  const AgentDetailsProfileSection({
    required this.createdAt,
    required this.email,
    required this.profilePicture,
    required this.username,
    Key? key,
  }) : super(key: key);

  Widget cellTextContent(
    String title, {
    Color? color = Colors.black,
  }) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Text(
        title,
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: color,
          fontSize: 10,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  TableRow singleRow(String title, String value) {
    Widget addMargin(Widget? widget) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: widget,
      );
    }

    return TableRow(
      children: [
        TableCell(
          child: addMargin(
            cellTextContent(title, color: Colors.black54),
          ),
        ),
        TableCell(
          child: addMargin(cellTextContent(value)),
        ),
      ],
    );
  }

  List<TableRow> tableRows() {
    return [
      singleRow("Email address", email),
      singleRow("Name", username),
      singleRow("Account from", createdAt),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShowImage(
          defaultAssets: "assets/user.png",
          size: const Size(120, 120),
          onlinePictureSrc: profilePicture,
          color: AppColors.primary,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(2),
                2: FixedColumnWidth(30),
              },
              children: tableRows(),
            ),
          ),
        ),
      ],
    );
  }
}

class AgentDetailsLinkSection extends StatelessWidget {
  const AgentDetailsLinkSection({super.key});

  void removeAgent() {}
  void suspendAgent() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MakeAgentDetailsLink(
            onPressed: () {},
            svgSrc: "assets/phone.svg",
            padding: 0,
          ),
          MakeAgentDetailsLink(
            onPressed: suspendAgent,
            svgSrc: "assets/suspend.svg",
          ),
          MakeAgentDetailsLink(
            onPressed: removeAgent,
            svgSrc: "assets/trash.svg",
          ),
        ],
      ),
    );
  }
}

class MakeAgentDetailsLink extends StatelessWidget {
  final void Function() onPressed;
  final String svgSrc;
  final double? padding;

  const MakeAgentDetailsLink({
    Key? key,
    required this.onPressed,
    required this.svgSrc,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(padding ?? 5.0),
        margin: const EdgeInsets.all(5.0),
        child: SvgPicture.asset(
          svgSrc,
          height: 32,
          width: 32,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AgentPermessions extends StatelessWidget {
  final bool manage_devices;
  final bool manage_agents;
  final List<dynamic> permessions;

  const AgentPermessions({
    super.key,
    required this.manage_agents,
    required this.manage_devices,
    required this.permessions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SetAgentPermession(
            manage_devices: manage_devices,
            manage_agents: manage_agents,
            permessions: permessions,
          ),
        ],
      ),
    );
  }
}
