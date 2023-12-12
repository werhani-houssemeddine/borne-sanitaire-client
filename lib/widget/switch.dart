import 'package:borne_sanitaire_client/widget/gestor_detector.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final void Function()? setActionState;
  const CustomSwitch({super.key, this.setActionState});

  @override
  // ignore: library_private_types_in_public_api
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  bool isChecked = false;
  final Duration _duration = const Duration(milliseconds: 370);
  late Animation<Alignment> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _duration);

    _animation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 40,
          height: 20,
          padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 1.0),
          decoration: BoxDecoration(
              color: isChecked ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                    color: isChecked ? Colors.green : Colors.red,
                    blurRadius: 12,
                    offset: const Offset(0, 8))
              ]),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: _animation.value,
                child: MakeGestureDetector(
                  onPressed: () {
                    setState(() {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                      if (widget.setActionState != null) {
                        widget.setActionState!();
                      }
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
