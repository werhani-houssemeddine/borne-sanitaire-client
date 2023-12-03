import 'package:flutter/material.dart';

class MakeGestureDetector extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final bool clickedCursor;
  const MakeGestureDetector({
    Key? key,
    required this.child,
    required this.onPressed,
    this.clickedCursor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: clickedCursor ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
