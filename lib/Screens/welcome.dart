import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:borne_sanitaire_client/layout/mobile/landing.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  /*if (Platform.isAndroid) {
    return LandingScreen(context);
  } else if (Platform.isWindows) {

  } else {

  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LandingScreen(context));
  }
}
