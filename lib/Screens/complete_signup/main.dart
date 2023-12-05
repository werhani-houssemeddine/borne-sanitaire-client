import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/Service/request.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CompleteUserDataShowModal(context, controller: _phoneNumberController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

// ignore: non_constant_identifier_names
CompleteUserDataShowModal(
  BuildContext context, {
  required TextEditingController controller,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: const Color.fromARGB(255, 241, 251, 255),
    barrierColor: Colors.black87.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    isDismissible: false,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CompleteUserSignUpAppBar(),
                const UpdateUserProfilePhoto(),
                UpdatePhoneNumber(phoneNumberController: controller),
                const SizedBox(height: 20),
                const Divider(),
              ],
            ),
            const Expanded(
              child: CompleteUserSignUpConfigDevicee(),
            ),
            ElevatedButton(
              onPressed: () => AutoRouter.of(context).replace(
                const HomeRoute(),
              ),
              child: const Text("Continue"),
            ),
          ],
        ),
      );
    },
  );
}

class CompleteUserSignUpAppBar extends StatelessWidget {
  const CompleteUserSignUpAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            MakeGestureDetector(
              onPressed: () =>
                  AutoRouter.of(context).replace(const HomeRoute()),
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        /*const Text(
          "We encourage you to complete the rest of this form "
          "for more better experience 😊",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),*/
      ],
    );
  }
}

class UpdateUserProfilePhoto extends StatefulWidget {
  const UpdateUserProfilePhoto({Key? key}) : super(key: key);

  @override
  State<UpdateUserProfilePhoto> createState() => _UpdateUserProfilePhotoState();
}

class _UpdateUserProfilePhotoState extends State<UpdateUserProfilePhoto> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img != null) {
      await upload(File(img.path));
      setState(() {
        image = img;
      });
    }
  }

  Image showImage() {
    if (image == null) {
      return const Image(image: AssetImage('assets/default_user1.png'));
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
                    color: Colors.blue.shade200,
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
              bottom: 0,
              right: 0,
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
  final TextEditingController phoneNumberController;
  const UpdatePhoneNumber({
    Key? key,
    required this.phoneNumberController,
  }) : super(key: key);

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
  const CompleteUserSignUpConfigDevicee({Key? key}) : super(key: key);
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
