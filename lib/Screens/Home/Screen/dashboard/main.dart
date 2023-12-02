import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/calendar.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/dashboard/statistical.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalendarWidget(),
            Statistical(),
          ],
        ),
      ),
    );
  }
}
