import 'package:borne_sanitaire_client/Screens/profile/change_password.dart';
import 'package:borne_sanitaire_client/Screens/profile/utils.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum SCREEN { EDIT_PASSWORD, EDIT_USERNAME, EDIT_PHONE_NUMBER }

Future displayChangePasswordBottomSheet(BuildContext context, String screen) {
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
        height: MediaQuery.of(context).size.height - 20,
        padding: const EdgeInsets.all(10.0),
        child: UpdateFieldState(screen: screen),
      );
    },
  );
}

class UpdateFieldState extends StatefulWidget {
  final String screen;
  const UpdateFieldState({Key? key, required this.screen}) : super(key: key);

  SCREEN? getScreen() {
    Map<String, SCREEN> title = {
      "Phone Number": SCREEN.EDIT_PHONE_NUMBER,
      "Password": SCREEN.EDIT_PASSWORD,
      "Name": SCREEN.EDIT_USERNAME,
    };
    return title[screen];
  }

  @override
  BaseUpdateFieldScreen createState() => BaseUpdateFieldScreen();
}

class BaseUpdateFieldScreen extends State<UpdateFieldState> {
  bool isDone = false;

  String getTtitleProperty(SCREEN? screen) {
    Map<SCREEN, String> title = {
      SCREEN.EDIT_PHONE_NUMBER: "Phone Number",
      SCREEN.EDIT_PASSWORD: "Password",
      SCREEN.EDIT_USERNAME: "Name",
    };
    return title[screen] ?? "Edit";
  }

  Widget? setContent() {
    void changeIsDoneToTrue() => setState(() => isDone = true);
    void changeIsDoneToFalse() => setState(() => isDone = false);

    void Function(bool) toggleIsDone() {
      return (isInputvalide) {
        if (isInputvalide) {
          changeIsDoneToTrue();
        } else {
          changeIsDoneToFalse();
        }
      };
    }

    SCREEN? screen = widget.getScreen();
    if (screen == null) return null;

    if (screen == SCREEN.EDIT_PASSWORD) {
      return ChangePasswordScreen(isDoneCallback: toggleIsDone());
    } else if (screen == SCREEN.EDIT_PHONE_NUMBER) {
    } else if (screen == SCREEN.EDIT_USERNAME) {}
  }

  @override
  Widget build(BuildContext context) {
    Widget? content = setContent();
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 241, 251, 255),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UpdateFieldAppBar(
            title: getTtitleProperty(widget.getScreen()),
            done: isDone,
          ),
          const Divider(),
          if (content != null) content
        ],
      ),
    );
  }
}

class UpdateFieldAppBar extends StatelessWidget {
  final String title;
  final bool done;
  const UpdateFieldAppBar({
    super.key,
    required this.title,
    required this.done,
  });

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
                child: const Icon(
                  Icons.close,
                  color: Colors.black87,
                  size: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          MakeGestureDetector(
            onPressed: () => done ? Navigator.of(context).pop() : () {},
            clickedCursor: done,
            child: SizedBox(
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 14,
                    color: done ? Colors.redAccent.shade400 : Colors.grey,
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
