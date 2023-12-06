import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/Screens/complete_signup/show_modal.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
    return Container(color: Colors.white);
  }
}

class CompleteUserSignUpWidget extends StatefulWidget {
  const CompleteUserSignUpWidget({Key? key}) : super(key: key);

  @override
  _CompleteUserSignUpWidgetState createState() =>
      _CompleteUserSignUpWidgetState();
}

class _CompleteUserSignUpWidgetState extends State<CompleteUserSignUpWidget> {
  bool isDeviceConfigurationSetted = false;
  bool isProfilePhotoSetted = false;
  bool isPhoneNumberSetted = false;

  bool get isDone =>
      isPhoneNumberSetted ||
      isDeviceConfigurationSetted ||
      isProfilePhotoSetted;

  @override
  void initState() => super.initState();

  void setUpdatedPhoto(bool state) =>
      setState(() => isProfilePhotoSetted = state);

  void setUpdatePhoneNumber(bool state) =>
      setState(() => isPhoneNumberSetted = state);

  void setUpdateDeviceConfiguration(bool state) =>
      setState(() => isDeviceConfigurationSetted = state);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CompleteUserSignUpAppBar(isDone: isDone),
              UpdateUserProfilePhoto(setUploadPhoto: setUpdatedPhoto),
            ],
          ),
          Expanded(
            child: CompleteUserSignUpConfigDevicee(
              updatePhoneNumberWidget: UpdatePhoneNumber(),
            ),
          ),
          const ContinueButton(),
        ],
      ),
    );
  }
}

class CompleteUserSignUpAppBar extends StatelessWidget {
  final bool isDone;

  const CompleteUserSignUpAppBar({
    Key? key,
    required this.isDone,
  }) : super(key: key);

  MakeGestureDetector makeAppBarLinks({
    required onPressed,
    required link,
    required color,
  }) {
    return MakeGestureDetector(
      onPressed: onPressed,
      child: Text(
        link,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeAppBarLinks(
            onPressed: () => AutoRouter.of(context).replace(const HomeRoute()),
            link: "Skip",
            color: Colors.black45,
          ),
          makeAppBarLinks(
            onPressed: () {},
            link: "done",
            color: isDone ? Colors.redAccent.shade400 : Colors.black45,
          ),
        ],
      ),
    );
  }
}

class UpdateUserProfilePhoto extends StatefulWidget {
  final void Function(bool) setUploadPhoto;
  const UpdateUserProfilePhoto({
    Key? key,
    required this.setUploadPhoto,
  }) : super(key: key);

  @override
  State<UpdateUserProfilePhoto> createState() => _UpdateUserProfilePhotoState();
}

class _UpdateUserProfilePhotoState extends State<UpdateUserProfilePhoto> {
  bool anyImageSetted = false;

  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img != null) {
      // await upload(File(img.path));
      setState(() {
        image = img;
        anyImageSetted = true;
      });
      widget.setUploadPhoto(true);
    } else {
      if (anyImageSetted == false) {
        widget.setUploadPhoto(false);
      }
    }
  }

  Widget showImage() {
    if (image == null) {
      // return const Image(image: AssetImage('assets/default_user1.png'));
      return const Center(
        child: Icon(
          Icons.person,
          size: 75,
        ),
      );
    } else {
      return Image.file(
        File(image!.path),
        fit: BoxFit.cover,
        scale: 0.5,
        height: 90,
        width: 90,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 150,
      width: double.infinity,
      child: Center(
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(width: 3, color: Colors.blue),
                  ),
                ),
                ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(image == null ? 10 : 0),
                    child: showImage(),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 1.5,
              right: 1.5,
              child: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 241, 251, 255),
                ),
                child: MakeGestureDetector(
                  onPressed: () => getImage(ImageSource.gallery),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((40 - 3) / 2),
                      color: Colors.black,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdatePhoneNumber extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();

  UpdatePhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNumberController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Enter Your Phone Number',
        hintText: 'Phone Number',
        focusColor: AppColors.primary,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.phone,
      maxLength: 8,
      onChanged: (String? value) => {
        if (phoneNumberController.text.trim() == "")
          phoneNumberController.clear(),
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a valid phone number';
        }

        if (double.tryParse(value) == null) {
          return 'Invalid format, numbers only';
        }

        return null;
      },
    );
  }
}

class CompleteUserSignUpConfigDevicee extends StatelessWidget {
  final StatelessWidget updatePhoneNumberWidget;

  const CompleteUserSignUpConfigDevicee({
    Key? key,
    required this.updatePhoneNumberWidget,
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
                    TextFormField(
                      // controller: phoneNumberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Enter the maximum visitors number',
                        focusColor: AppColors.primary,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.phone,

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid number';
                        }

                        if (double.tryParse(value) == null) {
                          return 'Invalid format, numbers only';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    MakeGestureDetector(
                      onPressed: () => AddAgentBuilder(context),
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Add New Agent",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
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
