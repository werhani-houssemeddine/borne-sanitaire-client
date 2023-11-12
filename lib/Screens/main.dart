// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'welcome.dart' as Welcome;

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Hello every one");
  }
}
