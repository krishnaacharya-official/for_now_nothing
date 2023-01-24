import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/models/products_main_model.dart';

class SpecialOffersScreen extends StatelessWidget {
  List<dynamic> homeSpecialProducts;
  SpecialOffersScreen({super.key, required this.homeSpecialProducts});

  final specialOfferTileHeight = 16 * 8.toDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Special Offers".appBarText(),
        leading: IconButton(
            onPressed: () {
              /**alert: Make sure instead of using pop you use go to the previous page
               * Because when the internet switches off and on , no navigation stack is preserved
               */
              context.goNamed(Routes.homeMain);
            },
            icon: const Icon(Icons.navigate_before)),
      ),
      body: ListView.builder(
        itemCount: homeSpecialProducts.length,
        itemBuilder: (context, index) {
          HomeProductModel homeSpecial = homeSpecialProducts[index];
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () {
                  context.pushNamed(Routes.homeProductList,
                      extra: homeSpecial,
                      queryParams: {'appBarTitle': "Discount Sale"});
                },
                child: SizedBox(
                  width: double.infinity,
                  height: specialOfferTileHeight,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: homeSpecial.image.url,
                    placeholder: (context, url) {
                      return Container(
                          color: Colors.grey.shade300,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            widthFactor: 0.5,
                            child: SvgPicture.asset(
                              'assets/svg/placeholder.svg',
                              color: Colors.grey.shade600,
                            ),
                          ));
                    },
                  ),
                ),
              )).marginDown();
        },
      ).paddingAll(16),
    );
  }

  // body: ListView(children: [
  //   ClipRRect(
  //           borderRadius: BorderRadius.circular(20),
  //           child: Image.asset('assets/images/home/special_offers1.png'))
  //       .marginDown(),
  //   ClipRRect(
  //           borderRadius: BorderRadius.circular(20),
  //           child: Image.asset('assets/images/home/special_offers2.png'))
  //       .marginDown(),
  //   ClipRRect(
  //           borderRadius: BorderRadius.circular(20),
  //           child: Image.asset('assets/images/home/special_offers3.png'))
  //       .marginDown(),
  //   ClipRRect(
  //           borderRadius: BorderRadius.circular(20),
  //           child: Image.asset('assets/images/home/special_offers4.png'))
  //       .marginDown(),
  //   ClipRRect(
  //           borderRadius: BorderRadius.circular(20),
  //           child: Image.asset('assets/images/home/special_offers5.png'))
  //       .marginDown(),
  // ]).paddingAll(16),
}
