import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/Screens/profile/utils.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

class WelcomeMobileScreen extends StatelessWidget {
  const WelcomeMobileScreen({super.key});

  void Function() navigateToLoginScreen(BuildContext context) {
    return () {
      AutoRouter.of(context).push(const LoginRoute());
    };
  }

  void Function() navigateToSignUpScreen(BuildContext context) {
    return () {
      AutoRouter.of(context).push(const SignupRoute());
    };
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 4, 130, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: screenHeight * 0.2),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: AssetImage('assets/care.png'),
                    fit: BoxFit.cover,
                    width: 250,
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.35,
                padding: const EdgeInsets.all(8.0),
                margin: EdgeInsets.only(left: screenWidth * 0.05),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(25, 4, 130, 1),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "Sign in to access the application, or try "
                          "scanning your device qr code to create "
                          "new account.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // MakeGestureDetector(child: child, onPressed: onPressed)
                        ButtonLink(
                          buttonTitle: "Sign Up",
                          onPressed: navigateToSignUpScreen(context),
                        ),
                        ButtonLink(
                          buttonTitle: "Sign In",
                          onPressed: navigateToLoginScreen(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonLink extends StatelessWidget {
  final String buttonTitle;
  final void Function() onPressed;
  const ButtonLink({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 20,
        ),
        width: 120,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
