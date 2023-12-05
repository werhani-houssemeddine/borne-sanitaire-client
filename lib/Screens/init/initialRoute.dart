import 'package:borne_sanitaire_client/Screens/init/landingScreen.dart';
import 'package:flutter/material.dart';

import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/init/init_service.dart';

@RoutePage()
class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: AuthManager.initialize(),
          builder: (context, snapshot) {
            return _buildInitialScreen(context, snapshot);
          },
        ),
      ),
    );
  }

  void navigateToWelcomePage(BuildContext context) {
    AutoRouter.of(context).replace(const WelcomeRoute()).then((value) => {});
  }

  void navigateToHomePage(BuildContext context) {
    AutoRouter.of(context).replace(const HomeRoute(), onFailure: (failure) {
      print('Faillure to replace init route by home route $failure');
    }).then((value) => {});
  }

  Widget waitingWidget() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.red,
        size: 50,
      ),
    );
  }

  Widget _buildInitialScreen(
    BuildContext context,
    AsyncSnapshot<INITIALIZATION_RESPONSE> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        navigateToWelcomePage(context);
      } else if (snapshot.hasData) {
        INITIALIZATION_RESPONSE? data = snapshot.data;

        data == INITIALIZATION_RESPONSE.HOME
            ? navigateToHomePage(context)
            : navigateToWelcomePage(context);
      }
      return const LandingScreen();
    } else {
      return const LandingScreen();
    }
  }
}
