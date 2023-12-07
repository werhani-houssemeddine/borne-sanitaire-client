import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/controller/handle_request.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/show_modal.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/widget/device_visitors.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/widget/phone_number.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CompleteUserSignUp extends StatefulWidget {
  const CompleteUserSignUp({Key? key}) : super(key: key);

  @override
  State<CompleteUserSignUp> createState() => _CompleteUserSignUpState();
}

class _CompleteUserSignUpState extends State<CompleteUserSignUp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CompleteUserDataShowModal(
        context,
        child: const CompleteUserSignUpWidget(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.transparent),
    );
  }
}

class CompleteUserSignUpConfigDevicee extends StatelessWidget {
  final UpdatePhoneNumber updatePhoneNumberWidget;
  final DeviceMaxVisitorsWidget deviceMaxVisitorsWidget;

  const CompleteUserSignUpConfigDevicee({
    Key? key,
    required this.updatePhoneNumberWidget,
    required this.deviceMaxVisitorsWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double currentWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: currentWidth * 0.045,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: currentWidth * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Configure Your Device",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    updatePhoneNumberWidget,
                    deviceMaxVisitorsWidget,

                    const SizedBox(height: 16.0),
                    // MakeGestureDetector(
                    //   onPressed: () => AddAgentBuilder(context),
                    //   child: Container(
                    //     width: double.maxFinite,
                    //     margin: const EdgeInsets.symmetric(horizontal: 50),
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //       color: AppColors.primary,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: const Center(
                    //       child: Text(
                    //         "Add New Agent",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () {},
      child: Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
