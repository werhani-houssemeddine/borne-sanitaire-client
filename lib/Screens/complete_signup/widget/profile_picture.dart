import 'dart:io';

import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserProfilePhoto extends StatefulWidget {
  final void Function(bool, XFile?) setUploadPhoto;
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
      widget.setUploadPhoto(true, image);
    } else {
      if (anyImageSetted == false) {
        widget.setUploadPhoto(false, image);
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
