import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Categories".appBarText(),
      ),
      body: ListView(children: [
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/category1.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/category2.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/category3.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/category4.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/category5.png'))
            .marginDown(),
        ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/home/category6.png'))
            .marginDown(),
      ]).paddingAll(16),
    );
  }
}
