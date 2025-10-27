import 'package:flutter/material.dart';
import 'package:twit/utils/ui/sized_box.dart';

import '../../../../../utils/ui/shimmer_scaffold.dart';
import '../../../../../utils/ui/shimmer_skeleton.dart';

class TwitListShimmer extends StatelessWidget {
  const TwitListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerScaffold(
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(height: 50, width: 50, isCircle: true),
              8.widthBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: 30,
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                  8.heightBox,
                  Skeleton(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  4.heightBox,
                  Skeleton(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                  ),

                  8.heightBox,
                  Skeleton(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 100,
                  ),
                  16.heightBox,
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
