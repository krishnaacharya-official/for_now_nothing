import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_search.dart';

class DetailsScreen extends StatefulWidget {
  String sample;
  DetailsScreen({super.key, required this.sample});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  PageController? pageViewController;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String buttonGroup = "1kg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Details Screen".appBarText(),
        leading: const Icon(Icons.navigate_before),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2 - (16 * 2),
              child: Stack(
                children: [
                  PageView(
                    controller: pageViewController ??=
                        PageController(initialPage: 0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.network(
                        'https://picsum.photos/seed/319/600',
                        width:
                            MediaQuery.of(context).size.height / 2 - (16 * 2),
                        // height: 100,
                        fit: BoxFit.fill,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/404/600',
                        width: MediaQuery.of(context).size.width,
                        // height: 100,
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://picsum.photos/seed/943/600',
                        width: MediaQuery.of(context).size.width,
                        // height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0.95),
                    child: smooth_page_indicator.SmoothPageIndicator(
                      controller: pageViewController ??=
                          PageController(initialPage: 0),
                      count: 3,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) {
                        pageViewController!.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      effect: smooth_page_indicator.ExpandingDotsEffect(
                        expansionFactor: 3,
                        spacing: 8,
                        radius: 12,
                        dotWidth: 12,
                        dotHeight: 8,
                        dotColor: DesignColor.blue.withOpacity(0.2),
                        activeDotColor: DesignColor.blue.withOpacity(0.8),
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("BlackForest Cake", style: textStyleLargeRegular()),
                Row(
                  children: [
                    Text(
                      "\$300",
                      style: textStyleLargeBold(),
                    ).marginRight(16),
                    Text(
                      "\$300",
                      style: textStyleMediumRegular()
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ).marginRight(16),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: const Alignment(-1.548, -2.134),
                          end: const Alignment(1.548, 3.607),
                          colors: <Color>[
                            DesignColor.greenGradientStart,
                            DesignColor.greenGradientEnd
                          ],
                          stops: const <double>[0, 1],
                        ),
                      ),
                      child: Center(
                        child: Text('15% OFF', style: textStyleSmall()),
                      ),
                    ),
                  ],
                ).marginDown(16),
                "Select Variant".textLargeBold().marginDown(16),
                RadioListTile(
                    activeColor: DesignColor.blue,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: (buttonGroup == "1kg"
                                ? DesignColor.blue
                                : DesignColor.black)),
                        borderRadius: BorderRadius.circular(20)),
                    // shape: const BorderSide(color: Colors.green, width: 2),
                    groupValue: buttonGroup,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: "1kg",
                    onChanged: (val) {
                      setState(() {
                        buttonGroup = val.toString();
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            "\$400".textLargeBold().marginRight(),
                            Text(
                              "\$300",
                              style: textStyleMediumRegular().copyWith(
                                  decoration: TextDecoration.lineThrough),
                            ).marginRight(),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: DesignColor.green.withOpacity(.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "16%off",
                                style: textStyleSmall()
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        "1 kg".textLargeBold().marginRight(16)
                      ],
                    )).marginDown(8),
                RadioListTile(
                    activeColor: DesignColor.blue,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: (buttonGroup == "1/2kg"
                                ? DesignColor.blue
                                : DesignColor.black)),
                        borderRadius: BorderRadius.circular(20)),
                    groupValue: buttonGroup,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: "1/2kg",
                    onChanged: (val) {
                      setState(() {
                        buttonGroup = val.toString();
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            "\$400".textLargeBold().marginRight(),
                            Text(
                              "\$300",
                              style: textStyleMediumRegular().copyWith(
                                  decoration: TextDecoration.lineThrough),
                            ).marginRight(),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: DesignColor.green.withOpacity(.2),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "25%off",
                                style: textStyleSmall()
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        "1/2kg".textLargeBold().marginRight(16)
                      ],
                    )).marginDown(16),
                "Description".textLargeBold().marginDown(16),
                "There is no description for this product"
                    .textMediumRegular()
                    .marginDown(16),
                "Related Products".textLargeBold().marginDown(16),
                /**alert: How about using wrap inside the producttile
                 *  so that i dont have to set a hard coded value in the sized
                 * box
                 */
              ],
            ).paddingHorizontal(16).marginTop(16),
            SizedBox(
              height: 180,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                ProductTileSearch(
                        imageUrl: "assets/images/home/cake_2.png",
                        title: "Blackforest Cake",
                        discountedPrice: "\$320",
                        actualPrice: "\$500")
                    .marginRight(),
                ProductTileSearch(
                        imageUrl: "assets/images/home/cake_2.png",
                        title: "Blackforest Cake",
                        discountedPrice: "\$320",
                        actualPrice: "\$500")
                    .marginRight(),
                ProductTileSearch(
                        imageUrl: "assets/images/home/cake_2.png",
                        title: "Blackforest Cake",
                        discountedPrice: "\$320",
                        actualPrice: "\$500")
                    .marginRight(),
                ProductTileSearch(
                        imageUrl: "assets/images/home/cake_2.png",
                        title: "Blackforest Cake",
                        discountedPrice: "\$320",
                        actualPrice: "\$500")
                    .marginRight()
              ]),
            ).marginLeft(16)
          ],
        ),
      ),
      bottomNavigationBar: Material(
        elevation: 1,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 16,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ["Add to Cart".textLargeBold()]),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Buy Now",
                    style: textStyleLargeBold().copyWith(),
                  ),
                ],
              ),
            ),
          ).addGradient(
              const Alignment(-1.387, -1.83),
              const Alignment(1.571, 2.714),
              const Color(0xfffdeb71),
              const Color(0xfff8d800))
        ]),
      ),
    );
  }
}
