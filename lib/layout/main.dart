// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'mobile/landing.dart';
import 'mobile/login.dart';

// var _WidgetFactory = (Widget Function(BuildContext) widget) =>
//     (BuildContext context) => widget(context);

class Landing {
  static Mobile(BuildContext context) => LandingScreen(context);
  static Windows(BuildContext context) => const Text("Under Implementation");
}

class Login {
  static Mobile(BuildContext context) => LoginScreen(context);
  static Windows(BuildContext context) => const Text("Under Implementation");
}
