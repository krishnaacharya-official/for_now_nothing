import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/shimmer_home.dart';

class ShimmerAddress extends StatelessWidget {
  const ShimmerAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            shimmerContainer(60, 0, 50),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerContainer(10, 8, 50),
                  shimmerContainer(20, 8),
                  shimmerContainer(10, 0, 80)
                ],
              ),
            ),
          ]).paddingAll(16);
        },
      ),
    );
  }
}
