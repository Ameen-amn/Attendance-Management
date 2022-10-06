import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PercentageCircle extends StatelessWidget {
  const PercentageCircle({
    Key? key,
    required this.percentage,
    required this.progressRadius,
    required this.kfontSize,
    required this.lineWidth,
    required this.animation,
  }) : super(key: key);

  final double percentage;
  final double progressRadius;
  final double lineWidth;
  final double kfontSize;
  final bool animation;
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: progressRadius,
      percent: percentage,
      center: Text(
        ((percentage * 100) ~/ 1).toString() + '%',
        style: TextStyle(
          fontSize: kfontSize,
        ),
      ),
      progressColor: Colors.green,
      lineWidth: lineWidth,
      animation: animation,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
