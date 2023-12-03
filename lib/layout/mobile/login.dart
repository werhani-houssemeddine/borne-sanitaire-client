// ignore_for_file: non_constant_identifier_names

import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/style.dart';
import 'package:flutter/material.dart';

import 'package:borne_sanitaire_client/Screens/Login/form.dart';

Widget LoginScreen(BuildContext context) {
  Size currentSize = MediaQuery.of(context).size;
  return Container(
    height: currentSize.height,
    width: currentSize.width,
    color: AppColors.primary,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginScreenAppBar(),
        LoginScreenForm(),
      ],
    ),
  );
}

class LoginScreenAppBar extends StatelessWidget {
  const LoginScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        children: [
          MakeGestureDetector(
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class LoginScreenForm extends StatelessWidget {
  const LoginScreenForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double currentHeight = MediaQuery.of(context).size.height;
    final double currentWidth = MediaQuery.of(context).size.height;
    return Container(
      height: currentHeight * 0.85,
      width: currentWidth,
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: const Column(
        children: [
          Text(
            "Sign In",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          LoginFormWidget(),
        ],
      ),
    );
  }
}
