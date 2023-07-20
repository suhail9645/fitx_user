
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/sized_box.dart';

class ReportSkelton extends StatelessWidget {
  const ReportSkelton({
    super.key,
    required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: screenHeight / 10,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          spaceforHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (index) => Container(
                height: 28,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          spaceforHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                3,
                (index) => CircleAvatar(
                      radius: 38.0,
                      backgroundColor:
                          Colors.black.withOpacity(0.3),
                    )),
          ),
          spaceforHeight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (index) => Container(
                height: 28,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          spaceforHeight20,
          Container(
            height: screenHeight*0.40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          )
        ],
      ),
    );
  }
}
