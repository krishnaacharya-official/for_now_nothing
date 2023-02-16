import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class ProductTileHome extends StatelessWidget {
  String imageUrl;
  String title;
  int? discountedPrice;
  int actualPrice;
  int? discountRate;
  final productTileHeight = 16 * 11.5.toDouble();
  final productTileWidth = 130.toDouble();
  ProductTileHome({
    super.key,
    required this.imageUrl,
    required this.discountRate,
    required this.title,
    required this.discountedPrice,
    required this.actualPrice,
  });

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
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    // fadeInDuration: const Duration(milliseconds: 500),
                    imageUrl: imageUrl,
                    placeholder: (context, url) {
                      return Container(
                          width: double.infinity,
                          height: double.infinity,
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
                    /**alert: removes this before production */
                    errorWidget: (context, url, error) => Text("Error $error"),

                    height: double.infinity,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Stack(children: [
                      Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover))),
                      Visibility(
                        visible: getDiscountRateOrEmpty(discountRate) != "",
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              margin: const EdgeInsets.only(top: 4, right: 4),
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: const Alignment(-1.548, -2.134),
                                  end: const Alignment(1.548, 3.607),
                                  colors: [
                                    DesignColor.greenGradientStart,
                                    DesignColor.greenGradientEnd
                                  ],
                                  stops: const <double>[0, 1],
                                ),
                              ),
                              child: getDiscountRateOrEmpty(discountRate)
                                  .textMediumRegular()),
                        ),
                      )
                    ]),
                  )),
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
                getPriceWithRupeeTag(discountedPrice, textStyleLargeBold())
                    .marginRight(2),
                Visibility(
                  visible: getDiscountRateOrEmpty(discountRate) != "",
                  child: getPriceWithRupeeTag(
                          actualPrice,
                          textStyleSmall()
                              .copyWith(decoration: TextDecoration.lineThrough))
                      .marginLeft(8),
                )
              ],
            ).marginLeft(4)
          ],
        ),
      ),
    );
  }
}

String getDiscountRateOrEmpty(int? discount) {
  return discount == 0 ? "" : "$discount%";
}

String getDiscountRateOrEmptyoff(int? discount) {
  return discount == 0 ? "" : "$discount% off";
}

RichText getPriceWithRupeeTag(int? price, [TextStyle? textStyle]) {
  textStyle ??= textStyleLargeRegular();
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: '\u20B9', style: textStyle.copyWith(fontFamily: 'Roboto')),
        TextSpan(text: "$price", style: textStyle)
      ],
    ),
  );
}
