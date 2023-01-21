import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class ProductTileSearch extends StatelessWidget {
  String imageUrl;
  String title;
  String discountedPrice;
  String actualPrice;
  final productTileHeight = 16 * 11.5.toDouble();
  final productTileWidth = 130.toDouble();
  ProductTileSearch(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.discountedPrice,
      required this.actualPrice});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: DesignColor.white,
      borderRadius: BorderRadius.circular(10),
      borderOnForeground: false,
      type: MaterialType.card,
      child: SizedBox(
        height: productTileHeight,
        width: productTileWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: productTileWidth,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          imageUrl,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
                child: Container()),
            Text(
              title,
              maxLines: 1,
              style: textStyleMediumRegular()
                  .copyWith(overflow: TextOverflow.ellipsis),
            ).marginLeft(4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                discountedPrice.textLargeBold().marginLeftRight(4),
                Text(
                  actualPrice,
                  style: textStyleSmall()
                      .copyWith(decoration: TextDecoration.lineThrough),
                ).marginLeft(8)
              ],
            )
          ],
        ),
      ),
    );
  }
}
