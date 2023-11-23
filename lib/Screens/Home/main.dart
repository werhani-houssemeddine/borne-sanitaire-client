// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/current_user.dart';
import 'package:borne_sanitaire_client/Screens/Home/layout/android_layout.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget waitingWidget() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.red,
        size: 50,
      ),
    );
  }

  _initializedScreen() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          AutoRouter.of(context).push(const WelcomeRoute()).then((value) => {});
        } else if (snapshot.hasData) {
          if (Platform.isAndroid) {
            return const HomePageAndroidLayout();
          } else {
            return const HomePageAndroidLayout();
          }
        }
      }
      return waitingWidget();
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: User.getCurrentUserData(),
      builder: _initializedScreen(),
    );
  }
}
