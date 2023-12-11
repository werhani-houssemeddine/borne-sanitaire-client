import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/profile/update_fields.dart';
import 'package:borne_sanitaire_client/Screens/services/update_client.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_profile_change_photo.dart';

@RoutePage()
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _image;

  setPhoto(image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: const Color.fromARGB(255, 241, 251, 255),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EditProfileAppBar(image: _image),
          const Divider(),
          EditProfileChangePhoto(updatePhotoState: setPhoto),
          const Divider(),
          const EditProfileUserInfo(),
          const Divider(),
        ],
      ),
    );
  }
}

class EditProfileAppBar extends StatelessWidget {
  final XFile? image;
  const EditProfileAppBar({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MakeGestureDetector(
            onPressed: () => Navigator.of(context).pop(),
            child: Center(
              child: Container(
                width: 30,
                height: 30,
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.shade50,
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          MakeGestureDetector(
            onPressed: () {
              if (image != null) {
                try {
                  updateProfilePhoto(File(image!.path));
                  CurrentUser.isImageChanged = true;
                } catch (e) {}
              }
            },
            child: SizedBox(
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.redAccent.shade400,
                    decoration: TextDecoration.none,
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

class EditProfileUserInfo extends StatelessWidget {
  const EditProfileUserInfo({Key? key}) : super(key: key);

  Widget cellTextContent(
    String title, {
    Color? color = Colors.black,
    double size = 14,
  }) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Text(
        title,
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: color,
          fontSize: size,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  TableRow singleRow(String title, String value, {void Function()? onPressed}) {
    Widget addMargin(Widget? widget) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: widget,
      );
    }

    return TableRow(
      children: [
        TableCell(
          child: addMargin(cellTextContent(title, color: Colors.black54)),
        ),
        TableCell(
          child: addMargin(cellTextContent(value, size: 13)),
        ),
        TableCell(
          child: addMargin(
            onPressed == null
                ? const SizedBox.shrink()
                : MakeGestureDetector(
                    onPressed: onPressed,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  void Function() navigateToEditPasswordScreen(BuildContext context) {
    return () {
      displayChangePasswordBottomSheet(context, "Password");
    };
  }

  void Function() navigateToEditNameScreen(BuildContext context) {
    return () {
      displayChangePasswordBottomSheet(context, "Name");
    };
  }

  void Function() navigateToEditPhoneNumberScreen(BuildContext context) {
    return () {
      displayChangePasswordBottomSheet(context, "Phone Number");
    };
  }

  List<TableRow> tableRows(BuildContext context) {
    return [
      singleRow(
        "Name",
        CurrentUser.instance!.username,
        onPressed: navigateToEditNameScreen(context),
      ),
      singleRow("Email address", CurrentUser.instance!.email),
      singleRow(
        "Phone Number",
        (CurrentUser.instance?.phoneNumber ?? "Add a new phone number")
            .toString(),
        onPressed: navigateToEditPhoneNumberScreen(context),
      ),
      singleRow(
        "Password",
        "xxxx xxxx xxxx xxxx",
        onPressed: navigateToEditPasswordScreen(context),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(2),
          2: FixedColumnWidth(30),
        },
        children: tableRows(context),
      ),
    );
  }
}
