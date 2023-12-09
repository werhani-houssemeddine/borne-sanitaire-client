import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

Future AddAgentOrDeviceBuilder(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.bgColor,
    barrierColor: Colors.black87.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) => const AddAgentOrDevice(),
  );
}

class AddAgentOrDevice extends StatelessWidget {
  const AddAgentOrDevice({Key? key}) : super(key: key);

  void Function() addNewAgentClick(BuildContext context) {
    return () {
      AutoRouter.of(context).pop().then((value) => AddAgentBuilder(context));
    };
  }

  void Function() addNewDeviceClick(BuildContext context) {
    return () {
      AutoRouter.of(context).replace(const AddNewDeviceRoute());
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: MakeGestureDetector(
              onPressed: addNewAgentClick(context),
              child: Container(
                padding: const EdgeInsets.all(3.0),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: const Center(
                  child: Text(
                    "Add New Agent",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (Platform.isAndroid)
            MakeGestureDetector(
              onPressed: addNewDeviceClick(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 60,
                padding: const EdgeInsets.all(3.0),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Add New Device",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: Platform.isAndroid ? 14 : 10,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
