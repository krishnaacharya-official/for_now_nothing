import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_home.dart';

class ProductTileSearch extends StatelessWidget {
  String imageUrl;
  String title;
  int discountedPrice;
  int actualPrice;
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
              child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
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
                  /**alert: This can't be same in the production, error can't be shown in the image  */
                  errorWidget: (context, url, error) =>
                      Center(child: Text(error))),
            ),
            Text(
              title,
              maxLines: 1,
              style: textStyleMediumRegular()
                  .copyWith(overflow: TextOverflow.ellipsis),
            ).marginLeft(4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                // discountedPrice.textLargeBold().marginLeftRight(4),
                getPriceWithRupeeTag(discountedPrice, textStyleLargeBold())
                    .marginLeftRight(4),
                Visibility(
                  visible: discountedPrice - actualPrice != 0,
                  child: getPriceWithRupeeTag(
                          actualPrice,
                          textStyleSmall()
                              .copyWith(decoration: TextDecoration.lineThrough))
                      .marginLeft(8),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
