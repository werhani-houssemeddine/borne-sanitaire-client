import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents/service.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';

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
