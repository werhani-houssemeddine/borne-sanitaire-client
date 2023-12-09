import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/device.dart';
import 'package:borne_sanitaire_client/Screens/Signup/expired_device.dart';
import 'package:borne_sanitaire_client/Screens/Signup/response_service.dart';
import 'package:borne_sanitaire_client/Screens/Signup/signup_service.dart';
import 'package:borne_sanitaire_client/Screens/services/update_client.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

@RoutePage()
class AddNewDeviceRoute extends StatefulWidget {
  const AddNewDeviceRoute({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<AddNewDeviceRoute> {
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
          future: getQRCode(),
          builder: _scaningQRCode(),
        ),
      ),
    );
  }

  Future<String?> getQRCode() async {
    await Permission.camera.request();
    String? qrcode = await scanner.scan();
    return qrcode;
  }

  Widget Function(BuildContext, AsyncSnapshot<String?>) _scaningQRCode() {
    return (BuildContext context, AsyncSnapshot<String?> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data != null) {
          String data = snapshot.data as String;
          print("DEVICE ID $data");
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
    return FutureBuilder(
      future: checkDeviceID(deviceId),
      builder: (BuildContext context, AsyncSnapshot<CHECKING_DEVICE> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            CHECKING_DEVICE response = snapshot.data as CHECKING_DEVICE;
            print(snapshot.data);
            if (response == CHECKING_DEVICE.VALID_DEVICE) {
              return FutureBuilder(
                future: addNewDevice(deviceId),
                builder: ((context, snapshot) {
                  return MyDialog(deviceId: deviceId);
                }),
              );
            } else {
              return const ExpiredDeviceWidget();
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

class MyDialog extends StatefulWidget {
  final String deviceId;
  const MyDialog({super.key, required this.deviceId});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final bool _isLoading = false;
  final bool _isRequestSuccessful = false;

  TextEditingController _maxVisitors = TextEditingController();

  void Function() navigateToHomePage(BuildContext context) {
    return () => AutoRouter.of(context)
        .replaceAll([const HomeRoute()]).then((value) => null);
  }

  void setDeviceMaxVisitors(String deviceId) {
    String value = _maxVisitors.value.text.trim();
    setMaxVisitors(value, deviceId);
  }

  void Function() setConfiguration(context, String deviceId) {
    return () {
      navigateToHomePage(context);
      setDeviceMaxVisitors(deviceId);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, -3),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          width: double.infinity,
          // height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Device added successfully. Please set the max visitors, "
                "and for more configuration, check the device in the "
                "devices screen.",
              ),
              const SizedBox(height: 16),
              TextFormField(
                autofocus: true,
                /*style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),*/
                controller: _maxVisitors,
                decoration: InputDecoration(
                  labelText: 'Enter the maximum visitors number',
                  focusColor: AppColors.primary,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _isRequestSuccessful == false
                      ? const SizedBox.shrink()
                      : _isRequestSuccessful
                          ? const Icon(Icons.check,
                              color: Colors.green, size: 36)
                          : const Icon(Icons.close,
                              color: Colors.red, size: 36),
              Row(
                children: [
                  Expanded(
                    child: MakeGestureDetector(
                        onPressed: navigateToHomePage(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MakeGestureDetector(
                      onPressed: setConfiguration(context, widget.deviceId),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
