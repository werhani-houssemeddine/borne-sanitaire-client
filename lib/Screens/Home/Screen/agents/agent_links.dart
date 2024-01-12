import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentAction {
  static void removeAgent({
    required BuildContext context,
    required int agentId,
  }) async {
    await AgentService.deleteAgent(agentId);
    if (context.mounted) {
      await navigateToAgentScreen(context);
    }
  }

  static void suspendAgent({
    required BuildContext context,
    required int agentId,
  }) async {
    await AgentService.suspendAgent(agentId);
    if (context.mounted) {
      await navigateToAgentScreen(context);
    }
  }

  static void restoreAgent({
    required BuildContext context,
    required int agentId,
  }) async {
    await AgentService.restoreAgent(agentId);
    if (context.mounted) {
      await navigateToAgentScreen(context);
    }
  }

  static navigateToAgentScreen(BuildContext context) async {
    if (context.mounted) {
      await AutoRouter.of(context).popAndPush(const AgentsRoute());
    }
  }
}

class AgentDetailsLinkSection extends StatelessWidget {
  final int agentId;
  final bool isActif;

  const AgentDetailsLinkSection({
    super.key,
    required this.agentId,
    required this.isActif,
  });

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
          if (isActif)
            MakeAgentDetailsLink(
              onPressed: () =>
                  AgentAction.suspendAgent(context: context, agentId: agentId),
              svgSrc: "assets/suspend.svg",
            )
          else
            MakeAgentDetailsLink(
              onPressed: () =>
                  AgentAction.suspendAgent(context: context, agentId: agentId),
              svgSrc: "assets/restore.svg",
            ),
          MakeAgentDetailsLink(
            onPressed: () =>
                AgentAction.removeAgent(context: context, agentId: agentId),
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
