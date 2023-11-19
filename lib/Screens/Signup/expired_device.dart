import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

class ExpiredDeviceWidget extends StatelessWidget {
  const ExpiredDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Card(
          elevation: 30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 500,
                    minHeight: 300,
                    maxWidth: 950,
                    minWidth: 500,
                  ),
                  child: const Image(
                    image: AssetImage("assets/expired_device.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                const Text("OOPS INVALID QR CODE"),
                const Text(
                  'The QR Code is invalid or expired please rescan the QR Code',
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("GET BACK"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          AutoRouter.of(context).pop().then((e) => {
                                AutoRouter.of(context)
                                    .push(const SignupRoute())
                                    .then((value) => {})
                              });
                        },
                        child: const Text("SCAN AGAIN"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
