import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Statistical extends StatelessWidget {
  const Statistical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1, color: Colors.purple),
        ),
        child: const Row(
          children: [
            Expanded(
              flex: 2,
              child: StatisticalDetails(),
            ),
            Expanded(
              flex: 1,
              child: PercentIndicator(),
            ),
          ],
        ));
  }
}

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 5.0,
      percent: 156 / 200,
      center: Text((156 / 200).toStringAsFixed(2)),
      progressColor: const Color.fromRGBO(1, 65, 189, 1),
      backgroundColor: Colors.blue.shade200,
      rotateLinearGradient: true,
      animation: true,
      animationDuration: 800,
      circularStrokeCap: CircularStrokeCap.square,
    );
  }
}

class StatisticalDetails extends StatelessWidget {
  const StatisticalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "There is 156 persons",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "156/200",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
