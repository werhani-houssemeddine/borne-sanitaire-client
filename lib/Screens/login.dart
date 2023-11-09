import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:borne_sanitaire_client/layout/main.dart' show Login;

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(body: Login.Mobile(context));
    } else {
      // return Scaffold(body: Landing.Windows(context));
      // return const Text("Under Implementation");
      return Scaffold(body: Login.Mobile(context));
    }
  }
}
