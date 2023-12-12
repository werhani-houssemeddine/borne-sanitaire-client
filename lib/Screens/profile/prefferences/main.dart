import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:borne_sanitaire_client/widget/switch.dart';
import 'package:flutter/material.dart';

class PrefferencesScreen extends StatelessWidget {
  const PrefferencesScreen({Key? key}) : super(key: key);

  List<Widget> get agentNotifications => const [
        X(
          title: "Current number of visitors is too high",
          description: "Receive notifications when the number of visitors is "
              "approaching the maximum limit. This helps in making "
              "timely decisions.",
        ),
        X(
          title: "Current number of visitors has reached the maximum limit",
          description: "Receive notifications when the maximum "
              "number of visitors has been reached.",
        ),
      ];

  List<Widget> get adminNotifications => [
        ...agentNotifications,
        const X(
          title: 'Receive Agent Response',
          description:
              'Receive notifications when the agent responds to a request '
              'or when the request expires.',
        ),
        const X(
          title: 'Agent Device Configuration Change',
          description: 'Receive notifications when one of your agents changes '
              'their device configuration.',
        ),
        const X(
          title: 'Agent Account Suspension or Deletion',
          description:
              'Receive notifications when your agent deletes their account '
              'or suspends it.',
        ),
      ];

  List<Widget> get listOfNotifications => CurrentUser.instance!.role == "ADMIN"
      ? adminNotifications
      : agentNotifications;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 20,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ArrowBack(),
            const Divider(),
            ...listOfNotifications,
          ],
        ),
      ),
    );
  }
}

class X extends StatelessWidget {
  final String title;
  final String description;
  const X({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            const CustomSwitch(),
          ],
        ),
      ),
    );
  }
}
