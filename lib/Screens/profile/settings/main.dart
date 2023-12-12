import 'package:borne_sanitaire_client/Screens/profile/settings/otp_auth.dart';
import 'package:borne_sanitaire_client/Screens/profile/settings/suspend_account.dart';
import 'package:borne_sanitaire_client/widget/arrow_back.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - 20,
      padding: const EdgeInsets.all(8.0),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Settigns(),
          DeleteAccount(),
        ],
      ),
    );
  }
}

class Settigns extends StatelessWidget {
  const Settigns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ArrowBack(),
        Divider(),
        EnableOTPAuth(),
        SizedBox(height: 16),
        SuspendAccount(),
      ],
    );
  }
}

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () => showConfirmationDialog(context),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 0.5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: const Center(
          child: Text(
            "Delete Account",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool?> showConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to do this?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirm'),
        ),
      ],
    ),
  );
}
