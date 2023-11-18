import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Signup/signup_service.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: FutureBuilder(
          future: _scan(),
          builder: _scaningQRCode(),
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

  Widget Function(BuildContext, AsyncSnapshot<String?>) _scaningQRCode() {
    return (BuildContext context, AsyncSnapshot<String?> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data != null) {
          String data = snapshot.data as String;
          print("DATA SCANNED $data");
          return _accessToSignupForm(data);
        } else {
          return const Text("Will be here as soon as possible 😊");
        }
      } else {
        return _ProgressIndicator();
      }
    };
  }

  Widget _accessToSignupForm(String deviceId) {
    // We check if the id is valid? id is the data comming from the qrcode

    return FutureBuilder(
      future: checkDeviceID(deviceId),
      builder: (BuildContext context, AsyncSnapshot<CHECKING_DEVICE> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            CHECKING_DEVICE response = snapshot.data as CHECKING_DEVICE;

            if (response == CHECKING_DEVICE.VALID_DEVICE) {
              return const Text("SINGUP WIDGET");
            } else {
              return const Text("EXPIRED");
            }
          }
        }
        return _ProgressIndicator();
      },
    );
  }
}

// ignore: non_constant_identifier_names
Widget _ProgressIndicator() {
  return const Center(
    child: CircularProgressIndicator.adaptive(),
  );
}
