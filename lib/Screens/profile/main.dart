import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/profile/logout.dart';
import 'package:borne_sanitaire_client/Screens/profile/settings/main.dart';
import 'package:borne_sanitaire_client/config.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/data/user.dart';
import 'package:borne_sanitaire_client/widget/show_bottom_modal.dart';
import 'package:flutter/material.dart';

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
                Navigator.of(context).pop();
              },
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
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                child: const Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
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
  Image showImage(String URL_IMAGE) {
    return Image.network(
      URL_IMAGE,
      fit: BoxFit.cover,
      scale: 0.5,
      height: 90,
      width: 90,
    );
  }

  const ProfileScreenUserInfo({Key? key}) : super(key: key);
  Widget profilePhoto() {
    var picutureURL = CurrentUser.instance?.profilePicture;
    var fullPictureURL = picutureURL != null
        ? "http://$BASE_URL/api/client/update$picutureURL"
        : "";

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
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular((120 - 4) / 2),
              color: Colors.white,
            ),
            child: picutureURL != null ? showImage(fullPictureURL) : null,
          ),
        ),
      ),
    );
  }

  Widget showEmailAndFullName() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            CurrentUser.instance!.username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            CurrentUser.instance!.email,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  void nvaigateToEditProfile(BuildContext context) {
    AutoRouter.of(context).push(const EditProfile()).then((value) => null);
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
        ],
      ),
    );
  }
}

class ProfileScreenLinks extends StatelessWidget {
  const ProfileScreenLinks({Key? key}) : super(key: key);

  showSettingsModal(BuildContext context) {
    ShowModalBttomSheet(
      context,
      child: const SettingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 54),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MakeCustomLink(
              linkTitle: "Settings",
              icon: Icons.settings,
              backgroundColor: Colors.blue,
              onPressed: () => showSettingsModal(context),
            ),
            const Divider(),
            MakeCustomLink(
              linkTitle: "Account",
              icon: Icons.account_circle_sharp,
              backgroundColor: Colors.green,
              onPressed: () => AutoRouter.of(context).navigate(
                const EditProfile(),
              ),
            ),
            const Divider(),
            MakeCustomLink(
              linkTitle: "Prefferences",
              icon: Icons.settings,
              backgroundColor: Colors.purpleAccent,
              onPressed: () => {},
            ),
            const Divider(),
            MakeCustomLink(
              linkTitle: "Log out",
              icon: Icons.logout,
              backgroundColor: Colors.redAccent,
              onPressed: () => ShowLogoutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}

class MakeCustomLink extends StatelessWidget {
  final String linkTitle;
  final IconData icon;
  final Color? backgroundColor;
  final void Function() onPressed;

  const MakeCustomLink({
    Key? key,
    required this.linkTitle,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  Widget gestureDectorBuilder(Widget widget) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
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
          Expanded(
            child: gestureDectorBuilder(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // textBaseline: TextBaseline.ideographic,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: backgroundColor,
                        ),
                        child: Icon(
                          icon,
                          size: 24,
                          weight: 10,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text(
                          linkTitle,
                          style: const TextStyle(
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.normal,
                            fontSize: 13,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
