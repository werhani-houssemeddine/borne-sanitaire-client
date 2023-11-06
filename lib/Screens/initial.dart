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
      builder: initialScreen(),
    )));
  }
}

initialScreen() {
  return (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        AutoRouter.of(context).push(const WelcomeRoute()).then((value) => {});
      } else if (snapshot.hasData) {
        AutoRouter.of(context).push(const WelcomeRoute()).then((value) => {});
      }
      return waitingWidget();
    } else {
      return waitingWidget();
    }
  };
}

Widget waitingWidget() {
  return Center(
    child: LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.red,
      size: 50,
    ),
  );
}
