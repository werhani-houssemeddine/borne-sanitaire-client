import 'package:flutter/material.dart';

Future displayProfileBottomSheet(BuildContext context) {
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
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
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
                            "Username",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "example@email.com",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          if (phoneNumber)
                            Text(
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
                    const _CustomButton(
                      buttonIcon: Icons.person_outline,
                      buttonText: "Profile",
                    ),
                    Container(height: 1, color: Colors.black, width: 300),
                    const _CustomButton(
                      buttonIcon: Icons.block,
                      buttonText: "Susspend Account",
                    ),
                    Container(height: 1, color: Colors.black, width: 300),
                    const _CustomButton(
                      buttonIcon: Icons.logout_rounded,
                      buttonText: "Logout",
                    ),
                    Container(height: 1, color: Colors.black, width: 300),
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

  const _CustomButton({
    required this.buttonText,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          print('Container clicked!');
        },
        child: Container(
          width: 400,
          height: 60,
          margin: const EdgeInsets.only(top: 5),
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
                    size: 32,
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
    );
  }
}
