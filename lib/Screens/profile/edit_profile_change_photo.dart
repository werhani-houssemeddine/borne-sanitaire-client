import 'dart:io';

import 'package:borne_sanitaire_client/config.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileChangePhoto extends StatefulWidget {
  final void Function(XFile) updatePhotoState;
  const EditProfileChangePhoto({
    Key? key,
    required this.updatePhotoState,
  }) : super(key: key);

  @override
  State<EditProfileChangePhoto> createState() => _EditProfileChangePhotoState();
}

class _EditProfileChangePhotoState extends State<EditProfileChangePhoto> {
  bool anyImageSetted = false;

  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img != null) {
      setState(() {
        image = img;
        anyImageSetted = true;
      });
      widget.updatePhotoState(img);
    } else {
      if (anyImageSetted == false) {}
    }
  }

  Widget showImage(String URL_IMAGE) {
    if (image == null) {
      return Image.network(
        URL_IMAGE,
        fit: BoxFit.cover,
        scale: 0.5,
        height: 90,
        width: 90,
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
    var picutureURL = CurrentUser.instance?.profilePicture;
    var fullPictureURL = picutureURL != null
        ? "http://$BASE_URL/api/client/update$picutureURL"
        : "";
    print("TESTTTT ${CurrentUser.isImageChanged}");

    return Container(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Stack(
          children: [
            ClipOval(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.green,
                ),
                child: picutureURL != null ? showImage(fullPictureURL) : null,
              ),
            ),
            Positioned(
              bottom: 8,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
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
