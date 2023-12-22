import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Service/current_user.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/interface.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/main.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/service.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/widget/app_bar.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/widget/device_visitors.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/widget/phone_number.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/widget/profile_picture.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompleteUserSignUpWidget extends StatefulWidget {
  final String deviceId;
  const CompleteUserSignUpWidget({
    Key? key,
    required this.deviceId,
  }) : super(key: key);

  @override
  _CompleteUserSignUpWidgetState createState() =>
      _CompleteUserSignUpWidgetState();
}

class _CompleteUserSignUpWidgetState extends State<CompleteUserSignUpWidget> {
  bool isDeviceConfigurationSetted = false;
  bool isProfilePhotoSetted = false;
  bool isPhoneNumberSetted = false;

  XFile? profilePicture;
  String? phoneNumberValue;
  String? visitorNumber;

  String? updatePhoneTextError;

  bool get isDone =>
      isPhoneNumberSetted ||
      isDeviceConfigurationSetted ||
      isProfilePhotoSetted;

  @override
  void initState() => super.initState();

  void setUpdatedPhoto(bool state, XFile? picture) => setState(() {
        isProfilePhotoSetted = state;
        profilePicture = picture;
      });

  void setUpdatePhoneNumber(bool state, String? phone) => setState(() {
        isPhoneNumberSetted = state;
        phoneNumberValue = phone;
      });

  void setUpdateDeviceConfiguration(bool state, String? visitors) =>
      setState(() {
        isDeviceConfigurationSetted = state;
        visitorNumber = visitors;
      });

  void handleSubmitForm() async {
    try {
      COMPLETE_SIGN_UP_RESPONSE updateResponse = await handleSubmit(
        maxVisitors: visitorNumber,
        deviceId: widget.deviceId,
        phone: phoneNumberValue,
        image: profilePicture != null ? File(profilePicture!.path) : null,
      );

      if (updateResponse == COMPLETE_SIGN_UP_RESPONSE.SUCCESS) {
        if (context.mounted) {
          User.getCurrentUserData(update: true);
          AutoRouter.of(context).navigate(const HomeRoute());
        }
        return;
      }

      if (updateResponse == COMPLETE_SIGN_UP_RESPONSE.INVALID_PHONE_NUMBER) {
        setState(() => updatePhoneTextError = "Invalid phone number");
      } else if (updateResponse ==
          COMPLETE_SIGN_UP_RESPONSE.USED_PHONE_NUMBER) {
        setState(() => updatePhoneTextError = "Used phone number ");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  get updatePhoneNumberWidget => UpdatePhoneNumber(
        setPhoneNumber: setUpdatePhoneNumber,
        errorText: updatePhoneTextError,
      );

  get deviceMaxVisitorsWidget => DeviceMaxVisitorsWidget(
        setDeviceMaxVisitors: setUpdateDeviceConfiguration,
        deviceId: widget.deviceId,
      );

  get appBar => CompleteUserSignUpAppBar(
        isDone: isDone,
        handleSubmit: handleSubmitForm,
      );

  get updateUserProfilePhoto => UpdateUserProfilePhoto(
        setUploadPhoto: setUpdatedPhoto,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appBar,
              updateUserProfilePhoto,
            ],
          ),
          Expanded(
            child: CompleteUserSignUpConfigDevicee(
              deviceMaxVisitorsWidget: deviceMaxVisitorsWidget,
              updatePhoneNumberWidget: updatePhoneNumberWidget,
            ),
          ),
        ],
      ),
    );
  }
}
