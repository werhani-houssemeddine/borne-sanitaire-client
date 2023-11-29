import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/Home/Controller/logout.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/utils/user.dart';
import 'package:flutter/material.dart';

Future displayProfileBottomSheet(BuildContext context) {
  CurrentUser? user = CurrentUser.instance;

  const bool phoneNumber = true;
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    barrierColor: Colors.black87.withOpacity(0.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade900,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            user?.username ?? "Username",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            user?.email ?? "user@example.com",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          if (phoneNumber)
                            const Text(
                              "56651363",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 1,
            width: double.maxFinite,
            color: Colors.black45,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CustomButton(
                      buttonIcon: Icons.person_outline,
                      buttonText: "Profile",
                      onpressed: () => {
                        context.router.navigate(const ProfileRoute()),
                      },
                    ),
                    _CustomButton(
                      buttonIcon: Icons.logout_rounded,
                      buttonText: "Logout",
                      onpressed: () => showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => const Logout(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _CustomButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final void Function() onpressed;

  const _CustomButton({
    required this.buttonText,
    required this.buttonIcon,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onpressed();
        },
        child: Center(
          child: Container(
            width: widthSize * 0.85,
            height: 45,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(
                      buttonIcon,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 300,
          maxWidth: 500,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 237, 237),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                child: const Text(
                  "Are You Sure You Want to Logout?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    textBaseline: null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () => logout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
