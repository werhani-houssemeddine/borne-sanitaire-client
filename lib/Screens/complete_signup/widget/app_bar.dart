import 'package:auto_route/auto_route.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';

class CompleteUserSignUpAppBar extends StatelessWidget {
  final bool isDone;
  final void Function() handleSubmit;

  const CompleteUserSignUpAppBar({
    Key? key,
    required this.isDone,
    required this.handleSubmit,
  }) : super(key: key);

  MakeGestureDetector makeAppBarLinks({
    required onPressed,
    required link,
    required color,
    required bool isClickable,
  }) {
    return MakeGestureDetector(
      onPressed: onPressed,
      clickedCursor: isClickable,
      child: Text(
        link,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          makeAppBarLinks(
            onPressed: () => AutoRouter.of(context).replace(const HomeRoute()),
            link: "Skip",
            isClickable: true,
            color: Colors.black45,
          ),
          makeAppBarLinks(
            isClickable: isDone,
            onPressed: isDone ? handleSubmit : () {},
            link: "done",
            color: isDone ? Colors.redAccent.shade400 : Colors.black45,
          ),
        ],
      ),
    );
  }
}
