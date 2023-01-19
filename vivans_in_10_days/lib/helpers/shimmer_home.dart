import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class ShimmerHome extends StatelessWidget {
  const ShimmerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          shimmerContainer(20),
          shimmerContainer(16 * 8),
          shimmerContainer(20),
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.grey[300]),
                        height: 16 * 9,
                      )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 1,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.grey[300]),
                        height: 16 * 9,
                      )),
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  flex: 1,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.grey[300]),
                        height: 16 * 9,
                      )),
                ),
              ],
            ),
          ).marginDown(16),
          shimmerContainer(20),
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.grey[300]),
                          height: 100,
                        )),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 1,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.grey[300]),
                          height: 100,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.grey[300]),
                          height: 100,
                        )),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 1,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.grey[300]),
                          height: 100,
                        )),
                  ),
                ],
              ),
            ],
          )
        ]).paddingAll(16),
      ),
    );
  }
}

Widget shimmerContainer(int height,
    [int marginDown = 16,
    double width = double.infinity,
    int marginright = 0]) {
  return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
          margin: EdgeInsets.only(
              bottom: marginDown.toDouble(), right: marginright.toDouble()),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              color: Colors.grey[300]),
          height: height.toDouble(),
          width: width));
}
