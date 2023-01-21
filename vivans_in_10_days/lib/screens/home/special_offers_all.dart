import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class SpecialOffersScreen extends StatelessWidget {
  const SpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Special Offers".appBarText(),
        leading: const Icon(Icons.navigate_before),
      ),
      body: ListView(children: [
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/special_offers1.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/special_offers2.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/special_offers3.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/special_offers4.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/special_offers5.png'))
            .marginDown(),
      ]).paddingAll(16),
    );
  }
}
