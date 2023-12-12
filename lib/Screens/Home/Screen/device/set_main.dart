import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:borne_sanitaire_client/widget/switch.dart';
import 'package:flutter/material.dart';

class SetMainDevice extends StatelessWidget {
  const SetMainDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeGestureDetector(
      child: const CustomSwitch(),
      onPressed: () {},
    );
  }
}
