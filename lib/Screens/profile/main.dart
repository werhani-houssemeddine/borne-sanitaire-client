import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/utils/user.dart';
import 'package:flutter/material.dart';

class User {
  static String email = CurrentUser.instance!.email;
  static String username = CurrentUser.instance!.username;
}

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: const EdgeInsets.all(5),
      child: const Column(
        children: [
          ProfileScreenAppBar(),
          ProfileScreenUserInfo(),
          Divider(),
          ProfileScreenLinks()
        ],
      ),
    );
  }
}

class ProfileScreenAppBar extends StatelessWidget {
  const ProfileScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                print("Tapped");
                Navigator.of(context).pop();
              },
              child: Center(
                child: Container(
                  width: 30,
                  height: 30,
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
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileScreenUserInfo extends StatelessWidget {
  const ProfileScreenUserInfo({Key? key}) : super(key: key);

  Widget profilePhoto() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        child: Container(
          // width: (120 - 5) / 2,
          // height: (120 - 5) / 2,
          decoration: BoxDecoration(
            // 120 => Parent Width Size
            // 4   => 2 Padding, 2 Border
            borderRadius: BorderRadius.circular((120 - 4) / 2),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget showEmailAndFullName() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          User.username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          User.email,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget editProfileWidget() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              decoration: TextDecoration.none,
              letterSpacing: 1.3,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          profilePhoto(),
          showEmailAndFullName(),
          editProfileWidget(),
        ],
      ),
    );
  }
}

class ProfileScreenLinks extends StatelessWidget {
  const ProfileScreenLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MakeCustomLink(linkTitle: "Settings"),
          MakeCustomLink(linkTitle: "User Management"),
          MakeCustomLink(linkTitle: "Prefferences"),
          Divider(),
          MakeCustomLink(linkTitle: "Log out"),
        ],
      ),
    );
  }
}

class MakeCustomLink extends StatelessWidget {
  final String linkTitle;
  const MakeCustomLink({Key? key, required this.linkTitle}) : super(key: key);

  Widget gestureDectorBuilder(Widget widget) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Center(
            child: Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue.shade50,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
                size: 12,
              ),
            ),
          ),
          Expanded(
            child: gestureDectorBuilder(
              Text(
                linkTitle,
                style: const TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          gestureDectorBuilder(
            const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
