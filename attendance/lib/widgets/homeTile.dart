import 'package:attendance/provider/subjectDetails.dart';
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
          color: Colors.white,
          border: Border.all(

              //  color: Colors.black54
              ),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(2, 2),
                blurStyle: BlurStyle.solid)
          ],
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
                  /*  classAttend.keys.map((e) async {
                    final _reqSubject = await findingSubject(e!);
                    if (_reqSubject.totalClassesTaken != 0) {
                      percentage = ((_reqSubject.totalClassesAttended /
                                  _reqSubject.totalClassesTaken) *
                              100)
                          .floor();
                    } else {
                      percentage = 0;
                    }
                  }); */
                  final lastlist = classAttend.values.toList();

                  // final _subj = findingSubject(tileHead);
                  // print('itemIndexx${classAttend[itemIndex]}');

                  if (lastlist[itemIndex][1] != 0) {
                    percentage =
                        ((lastlist[itemIndex][0] / lastlist[itemIndex][1]) *
                                100)
                            .floor();
                  } else {
                    percentage = 0;
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
