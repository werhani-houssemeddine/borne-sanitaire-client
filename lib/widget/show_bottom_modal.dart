import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ShowModalBttomSheet(BuildContext context, {required Widget child}) {
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
    builder: (context) => child,
  );
}
