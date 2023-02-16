import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_home.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_search.dart';
import 'package:vivans_in_10_days/models/product_model.dart';

// ignore: slash_for_doc_comments
/**optional: You can wrap the entire screen witin the CachedNetworkImage and in the placeholder
 * you can use the shimmer for details
  */
class DetailsScreen extends StatefulWidget {
  ProductModel productModel;
  DetailsScreen({super.key, required this.productModel});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  PageController? pageViewController;
  final productTileHeight = 16 * 11.5.toDouble();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String buttonGroup = "1kg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Details Screen".appBarText(),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.navigate_before)),
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
                    children: List.generate(
                      widget.productModel.images.length,
                      // (index) => Image.network(
                      //   widget.productModel.images[index].url,
                      //   width: MediaQuery.of(context).size.width,
                      //   fit: BoxFit.cover,
                      // ),
                      (index) => CachedNetworkImage(
                          imageUrl: widget.productModel.images[index].url,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                              color: Colors.grey.shade300,
                              child: FractionallySizedBox(
                                heightFactor: 0.5,
                                widthFactor: 0.5,
                                child: SvgPicture.asset(
                                  'assets/svg/placeholder.svg',
                                  color: Colors.grey.shade600,
                                ),
                              ))),
                    ),
                  ),
                  Visibility(
                    visible: widget.productModel.images.isNotEmpty,
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0.95),
                      child: smooth_page_indicator.SmoothPageIndicator(
                        controller: pageViewController ??=
                            PageController(initialPage: 0),
                        count: widget.productModel.images.length,
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
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.productModel.name, style: textStyleLargeRegular()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    // Text(
                    //   "\$300",
                    //   style: textStyleLargeBold(),
                    // ).marginRight(16),
                    getPriceWithRupeeTag(
                            widget.productModel.primaryDiscountedPrice,
                            textStyleLargeBold())
                        .marginRight(16),
                    Visibility(
                      visible: getDiscountRateOrEmpty(
                              widget.productModel.primaryDiscountedRate) !=
                          "",
                      child: getPriceWithRupeeTag(
                              widget.productModel.primaryPrice,
                              textStyleMediumRegular().copyWith(
                                  decoration: TextDecoration.lineThrough))
                          .marginRight(16),
                    ),

                    Visibility(
                      visible: getDiscountRateOrEmpty(
                              widget.productModel.primaryDiscountedRate) !=
                          "",
                      child: Container(
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
                          child: Text(
                              getDiscountRateOrEmptyoff(
                                  widget.productModel.primaryDiscountedRate),
                              style: textStyleSmall()),
                        ),
                      ),
                    ),
                  ],
                ).marginDown(16),
                Visibility(
                  visible: widget.productModel.typeOfProduct ==
                      Constants.TYPEOFPRODUCT_CAKE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  getPriceWithRupeeTag(
                                          widget.productModel
                                              .secondaryDiscountedPrice,
                                          textStyleLargeBold())
                                      .marginRight(),
                                  Visibility(
                                    visible: getDiscountRateOrEmpty(widget
                                            .productModel
                                            .secondaryDiscountedRate) !=
                                        "",
                                    child: getPriceWithRupeeTag(
                                      widget.productModel.secondaryPrice,
                                      textStyleMediumRegular().copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ).marginRight(),
                                  ),
                                  Visibility(
                                    visible: getDiscountRateOrEmpty(widget
                                            .productModel
                                            .secondaryDiscountedRate) !=
                                        "",
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color:
                                            DesignColor.green.withOpacity(.2),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        getDiscountRateOrEmptyoff(widget
                                            .productModel
                                            .secondaryDiscountedRate),
                                        style: textStyleSmall().copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
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
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getPriceWithRupeeTag(
                                          widget.productModel
                                              .primaryDiscountedPrice,
                                          textStyleLargeBold())
                                      .marginRight(),
                                  Visibility(
                                    visible: getDiscountRateOrEmpty(widget
                                            .productModel
                                            .primaryDiscountedRate) !=
                                        "",
                                    child: getPriceWithRupeeTag(
                                      widget.productModel.primaryPrice,
                                      textStyleMediumRegular().copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ).marginRight(),
                                  ),
                                  Visibility(
                                    visible: getDiscountRateOrEmpty(widget
                                            .productModel
                                            .primaryDiscountedRate) !=
                                        "",
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color:
                                            DesignColor.green.withOpacity(.2),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        getDiscountRateOrEmptyoff(widget
                                            .productModel
                                            .primaryDiscountedRate),
                                        style: textStyleSmall().copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              "1/2kg".textLargeBold().marginRight(16)
                            ],
                          )).marginDown(16),
                    ],
                  ),
                ),
                "Description".textLargeBold().marginDown(16),
                // (widget.productModel.description !="null"&& widget.productModel.description?.trim() !="")?widget.productModel.description?.textMediumRegular()
                //     .marginDown(16):
                (widget.productModel.description != "null" &&
                        widget.productModel.description?.trim() != "")
                    ? widget.productModel.description
                            ?.textMediumRegular()
                            .marginDown(16) ??
                        "There is no description for this product"
                            .textMediumRegular()
                            .marginDown(16)
                    : "There is no description for this product"
                        .textMediumRegular()
                        .marginDown(16),
                "Related Products".textLargeBold().marginDown(16),
                /**alert: How about using wrap inside the producttile
                 *  so that i dont have to set a hard coded value in the sized
                 * box
                 */
              ],
            ).paddingHorizontal(16).marginTop(8),
            // SizedBox(
            //   height: productTileHeight,
            //   child: productsListHorizontal(widget.products),
            // ),
            /**bug: Thiss comes very very very late, I need to figure out a way for this */
            FutureBuilder(
                future: BlocProvider.of<ProductsCubit>(context)
                    .fetchSimilarForDetailsPage(widget.productModel.categories,
                        widget.productModel.tags),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return SizedBox(
                      height: productTileHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          ProductModel productModel =
                              snapshot.data?[index] as ProductModel;
                          return ProductTileSearch(
                                  imageUrl: productModel.images[0].url,
                                  title: productModel.name,
                                  discountedPrice:
                                      productModel.primaryDiscountedPrice!,
                                  actualPrice: productModel.primaryPrice)
                              .marginRight();
                        },
                        itemCount: snapshot.data!.length > 6
                            ? 6
                            : snapshot.data!.length,
                      )).marginLeft(16);
                }))
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

  // ListView productsListHorizontal(products) {
  //   List<ProductModel> productModel = products;

  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: productModel .length > 7
  //         ? 8
  //         : productModel.length,
  //     itemBuilder: (context, index) {
  //       ProductModel productModel = productModel[index];
  //       return ProductTileHome(
  //               discountRate: productModel.primaryDiscountedRate,
  //               imageUrl: productModel.images[0].url,
  //               title: productModel.name,
  //               discountedPrice: productModel.primaryDiscountedPrice,
  //               actualPrice: productModel.primaryPrice)
  //           .marginRight(8);
  //     },
  //   );
  // }
}
