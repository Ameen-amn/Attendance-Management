import 'package:flutter/material.dart';

class PercentageCircle extends StatelessWidget {
  const PercentageCircle({
    Key? key,
    required this.percentage,
    required this.outerRadius,
    required this.innerRadius,
  }) : super(key: key);

  final int percentage;
  final double outerRadius;
  final double innerRadius;

  @override
  Widget build(BuildContext context) {
    return Center(
      // %  chart

      child: CircleAvatar(
        radius: outerRadius,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: innerRadius,
          child: Text(
            '$percentage%',
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
