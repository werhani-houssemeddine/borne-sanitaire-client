// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:borne_sanitaire_client/widget/form.dart';

Widget LoginScreen(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView(
      child: _CustomLoginBackground(context),
    ),
  );
}

Widget _CustomLoginBackground(BuildContext context) {
  Size currentSize = MediaQuery.of(context).size;
  return SizedBox(
    height: currentSize.height,
    width: currentSize.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: Card(
            elevation: 20,
            margin: const EdgeInsets.all(10),
            // borderRadius: BorderRadius.all(Radius.circular(50)),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(child: LoginFormWidget()),
            ),
          ),
        ),
        if (currentSize.height > 500) const Spacer(flex: 1),
      ],
    ),
  );
}
