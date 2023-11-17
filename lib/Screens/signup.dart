import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'dart:async';
import 'dart:typed_data';

import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const MyApp();
    } else {
      return const Text("Under Implementation");
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List bytes = Uint8List(0);

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: FutureBuilder(
            future: _scan(),
            builder: ((BuildContext context, AsyncSnapshot<String?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                return const Text("Text Here");
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            }),
          ),
        ),
      ),
    );
  }

  /*Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 30,
          child: InkWell(
            onTap: _scan,
            child: const Card(
              child: Text("Scan"),
            ),
          ),
        ),
      ],
    );
  }*/

  Future<String?> _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();

    return barcode;
  }
}
