// ignore_for_file: slash_for_doc_comments

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_home.dart';

/**alert:  Not satisfied by the height and width of the images . It might have overflow errors */
/**alert: While testing test in all the phones and see if the alignment works perfectly , make the title large and see all the possibilites  */
class ProductTileCategory extends StatelessWidget {
  String imageUrl;
  String title;
  int? discountedPrice;
  int actualPrice;
  int? discountRate;
  final productTileHeight = 16 * 11.5.toDouble();
  final productTileWidth = 120.toDouble();
  ProductTileCategory(
      {super.key,
      this.discountRate,
      required this.imageUrl,
      required this.title,
      required this.discountedPrice,
      required this.actualPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fitWidth,
              // fadeInDuration: const Duration(milliseconds: 500),
              imageUrl: imageUrl,
              placeholder: (context, url) {
                return Container(
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child: SvgPicture.asset(
                        'assets/svg/placeholder.svg',
                        color: Colors.grey.shade600,
                      ),
                    ));
              },

              /**alert: change this */
              errorWidget: (context, url, error) {
                return Center(child: Text(error));
              },
            ),
          ),
        ),
        Text(
          title,
          maxLines: 1,
          style:
              textStyleLargeRegular().copyWith(overflow: TextOverflow.ellipsis),
        ).marginLeft(4).marginTop(2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            getPriceWithRupeeTag(discountedPrice, textStyleLargeBold())
                .marginRight(8),
            // Text(
            //   actualPrice,
            // style: ,
            // ).marginLeft(8),
            Visibility(
              visible: getDiscountRateOrEmpty(discountRate) != "",
              child: getPriceWithRupeeTag(
                  actualPrice,
                  textStyleMediumRegular()
                      .copyWith(decoration: TextDecoration.lineThrough)),
            ),
            Visibility(
              visible: getDiscountRateOrEmpty(discountRate) != "",
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: DesignColor.green.withOpacity(.2)),
                  child: Text(
                    /**alert: change */
                    "$discountRate %",
                    style: textStyleMediumRegular().copyWith(
                        fontWeight: FontWeight.w700,
                        color: DesignColor.darkGreen),
                  )).marginLeft(8),
            )
          ],
        ).marginLeft(4)
      ],
    );
  }
}
