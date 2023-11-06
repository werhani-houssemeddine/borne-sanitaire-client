// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';

Widget LandingScreen(BuildContext context) {
  return Scaffold(
    body: Stack(fit: StackFit.expand, children: [
      _BackgroundImage(),
      _ButtonsContainer(context),
    ]),
  );
}

Widget _BackgroundImage() {
  return Container(
    padding: const EdgeInsets.only(top: 75),
    alignment: Alignment.topCenter,
    child: const Image(
        image: AssetImage("assets/welcome.png"), fit: BoxFit.contain),
  );
}

Widget _ButtonsContainer(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return ClipRRect(
      child: Container(
    alignment: Alignment.bottomCenter,
    child: Container(
        width: width * 0.9,
        margin: const EdgeInsets.only(bottom: 50),
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: _Buttons()),
  )
      /*BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        ),*/
      );
}

Widget _Buttons() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Expanded(flex: 1, child: _Button(() => null, "LOGIN")),
        // const Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 1, child: _Button(() => null, "GET STARTED"))
      ],
    ),
  );
}

Widget _Button(Function()? onPressed, String text) {
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(text)),
      ));
}
