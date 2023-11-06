import 'package:flutter/material.dart';
import 'package:borne_sanitaire_client/init.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:borne_sanitaire_client/layout/mobile/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  //final String os = Platform.operatingSystem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: FutureBuilder(
              future: init(),
              builder: initialScreen(),
            ))));
  }
}

initialScreen() {
  return (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        print("ERROR");
        // return waitingWidget();
        return LandingScreen(context);
      } else if (snapshot.hasData) {
        return LandingScreen(context);
      }
      // return waitingWidget();
      return LandingScreen(context);
    } else {
      // return waitingWidget();
      return LandingScreen(context);
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
