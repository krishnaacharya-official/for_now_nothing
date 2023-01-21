// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

/**alert:  Not satisfied by the height and width of the images . It might have overflow errors */
/**alert: While testing test in all the phones and see if the alignment works perfectly , make the title large and see all the possibilites  */
class ProductTileCategory extends StatelessWidget {
  String imageUrl;
  String title;
  String discountedPrice;
  String actualPrice;
  final productTileHeight = 16 * 11.5.toDouble();
  final productTileWidth = 120.toDouble();
  ProductTileCategory(
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
        // height: productTileHeight,
        // width: productTileWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2 - 16,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      imageUrl,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Text(
              title,
              maxLines: 1,
              style: textStyleLargeRegular()
                  .copyWith(overflow: TextOverflow.ellipsis),
            ).marginLeft(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.alphabetic,
              children: [
                discountedPrice.textLargeBold(),
                Text(
                  actualPrice,
                  style: textStyleSmall()
                      .copyWith(decoration: TextDecoration.lineThrough),
                ).marginLeft(8),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        // border: Border.all(color: DesignColor.green),
                        borderRadius: BorderRadius.circular(8),
                        // gradient: LinearGradient(
                        //   begin: const Alignment(-1.548, -2.134),
                        //   end: const Alignment(1.548, 3.607),
                        //   colors: [
                        //     DesignColor.greenGradientStart,
                        //     DesignColor.greenGradientEnd
                        //   ],
                        //   stops: const <double>[0, 1],
                        // ),
                        color: DesignColor.green.withOpacity(.2)),
                    child: Text(
                      "16% OFF",
                      style: textStyleSmall().copyWith(
                          fontWeight: FontWeight.w700,
                          color: DesignColor.darkGreen),
                    )).marginLeft(8)
              ],
            ).marginLeft(8)
          ],
        ),
      ),
    );
  }
}
