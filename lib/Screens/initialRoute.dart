import 'package:flutter/material.dart';

import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/init.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: init(),
          builder: _initialScreen(),
        ),
      ),
    );
  }
}

_initialScreen() {
  navigateToWelcomePage(BuildContext context) {
    AutoRouter.of(context).push(const WelcomeRoute()).then((value) => {});
  }

  navigateToHomePage(BuildContext context) {
    AutoRouter.of(context).push(const HomeRoute()).then((value) => {});
  }

  Widget waitingWidget() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.red,
        size: 50,
      ),
    );
  }

  return (
    BuildContext context,
    AsyncSnapshot<INITIALIZATION_RESPONSE> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        AutoRouter.of(context).push(const WelcomeRoute()).then((value) => {});
      } else if (snapshot.hasData) {
        INITIALIZATION_RESPONSE? data = snapshot.data;

        data == INITIALIZATION_RESPONSE.HOME
            ? navigateToHomePage(context)
            : navigateToWelcomePage(context);
      }
      return waitingWidget();
    } else {
      return waitingWidget();
    }
  };
}
