import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/profile/update_fields.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: const Color.fromARGB(255, 241, 251, 255),
      padding: const EdgeInsets.all(8.0),
      child: const Column(
        children: [
          EditProfileAppBar(),
          Divider(),
          EditProfileChangePhoto(),
          Divider(),
          EditProfileUserInfo(),
          Divider(),
          EditProfileDeleteAccount(),
        ],
      ),
    );
  }
}

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({Key? key}) : super(key: key);

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
            onPressed: () => Navigator.of(context).pop(),
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

class EditProfileChangePhoto extends StatelessWidget {
  const EditProfileChangePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(75),
                color: Colors.green,
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
                  onPressed: () => print("Change profile photo"),
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

class EditProfileDeleteAccount extends StatelessWidget {
  const EditProfileDeleteAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: () => print("Delete account"),
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 0.5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: const Center(
          child: Text(
            "Delete Account",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
