import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/shimmer_home.dart';

class ShimmerGrid extends StatelessWidget {
  late Size size;
  late double childWidth;
  late double childHeight;
  ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    childWidth = (size.width / 2);

    /**alert: I am having doubt with this hard coded value */
    childHeight = childWidth * 1.3;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          childAspectRatio: ((childWidth / childHeight)),
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: shimmerContainer(20),
                ),
                shimmerContainer(20),
                shimmerContainer(20, 8, size.width / 4)
              ]).paddingAll(8);
        });
  }
}
