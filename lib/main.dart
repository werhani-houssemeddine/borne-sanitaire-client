import 'package:borne_sanitaire_client/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return SafeArea(
        child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    ));
  }
}
