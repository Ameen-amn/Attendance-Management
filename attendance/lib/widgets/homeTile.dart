import 'package:attendance/widgets/percentage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String tileHead;
  final ValueListenable<Map<int?, List<int>>> clss;
  final int itemIndex;
  const HomeTile(
      {Key? key,
      required this.tileHead,
      required this.clss,
      required this.itemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(16)),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              tileHead,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: ValueListenableBuilder(
                valueListenable: clss,
                builder: (BuildContext ctx, Map<int?, List<int>> classAttend,
                    Widget? _) {
                  int percentage = 0;
                  //  subject=classAttend.keys.firstWhere((element) => subjectD,)
                  if (classAttend[itemIndex]![1] != 0) {
                    if (classAttend[itemIndex] != null) {
                      percentage = ((classAttend[itemIndex]![0] /
                                  classAttend[itemIndex]![1]) *
                              100)
                          .floor();
                    }
                  }

                  return PercentageCircle(
                    percentage: percentage / 100,
                    progressRadius: 25,
                    kfontSize: 14,
                    lineWidth: 5,
                    animation: true,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
