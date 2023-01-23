import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/shimmer_home.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_home.dart';
import 'package:vivans_in_10_days/models/products_main_model.dart';
import 'package:vivans_in_10_days/screens/home/nav_bar.dart';
import 'package:vivans_in_10_days/screens/home/search_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bool _visible = false;

  final specialOfferTileHeight = 16 * 8.toDouble();

  final flashSaleHeight = 240.toDouble();

  final flashSaleTileWidth = 16 * 6.5.toDouble();

  final flashSaleTileHeight = 16 * 9.toDouble();

  // final productTileHeight = 16 * 12.toDouble();
  final productTileHeight = 16 * 11.5.toDouble();

  final productTileWidth = 130.toDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DesignColor.grey,
        drawer: const NavBar(),
        appBar: AppBar(
          title: "Home".appBarText(),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () {
                  showSearch(
                      context: context, delegate: SearchScreenDelegate());
                }),
            IconButton(
              icon: const Icon(Icons.shopping_cart_rounded),
              onPressed: () {},
            )
          ],
        ),
        // body: const ShimmerAddress()
        body: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
          if (state is ProductsLoading) {
            return const ShimmerHome();
          }
          List<dynamic>? homeSpecialProducts = state.homeSpecialProducts;
          List<dynamic>? homeCategoryProducts = state.homeCategoryProducts;
          HomeProductModel homeSpecialPrimary = homeSpecialProducts?[0];
          HomeProductModel homeCategoryPrimary = homeCategoryProducts?[0];
          // debugPrint(homeSpecialModel.image.url);
          return ListView(children: [
            headRow("Special Offers")
                .marginDown()
                .marginTop()
                .paddingHorizontal(16),
            SizedBox(
              height: specialOfferTileHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // child: Container(
                //     color: Colors.grey.shade400,
                //     child: SvgPicture.asset(
                //       'assets/svg/placeholder.svg',
                //       color: Colors.grey.shade600,
                //     )),

                // child: Shimmer.fromColors(
                //   // baseColor: Colors.grey[300]!,
                //   baseColor: Colors.grey.shade500,
                //   highlightColor: Colors.grey[100]!,
                //   child: Container(
                //     color: Colors.black.withOpacity(0.4),
                //     child: SvgPicture.asset(
                //       'assets/svg/placeholder.svg',
                //       color: Colors.black,
                //       fit: BoxFit.fitHeight,
                //     ),
                //   ),
                // )

                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: homeSpecialPrimary.image.url,
                    // placeholder: (context, url) => Shimmer.fromColors(
                    //       // baseColor: Colors.grey[300]!,
                    //       baseColor: Colors.grey.shade500,
                    //       highlightColor: Colors.grey[100]!,
                    //       child: Container(
                    //         color: Colors.black.withOpacity(0.4),
                    //         child: SvgPicture.asset(
                    //           'assets/svg/placeholder.svg',
                    //           color: Colors.black,
                    //           fit: BoxFit.fitHeight,
                    //         ),
                    //       ),
                    //     ),
                    placeholder: (context, url) {
                      return Container(
                          color: Colors.grey.shade400,
                          child: SvgPicture.asset(
                            'assets/svg/placeholder.svg',
                            color: Colors.grey.shade600,
                          ));
                    },
                    /**alert: This can't be same in the production, error can't be shown in the image  */
                    errorWidget: (context, url, error) =>
                        Center(child: Text(error))),
              ),
              // child:
            ).marginDown().paddingHorizontal(16),
            flashSaleWidget(homeCategoryPrimary).marginDown(),
            headRow("Categories").paddingHorizontal(16).marginDown(),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      categoryTile(
                          context,
                          'assets/images/home/designer_cake.png',
                          "Designer Cake"),
                      categoryTile(
                          context,
                          'assets/images/home/flavored_cake.png',
                          "Flavored Cake"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categoryTile(context, 'assets/images/home/party_cake.png',
                        "Party Cake"),
                    categoryTile(
                        context, 'assets/images/home/snacks.png', "Snacks"),
                  ],
                )
              ],
            ).paddingHorizontal(16).marginDown(),
            BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
              if (state is ProductHomeMainLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProductMainLoaded) {
                return buildHomeSection(state.homeCategoryProducts!);
              }
              /**alert: Correct this */

              return "HOi".textLargeBold();
            })
            // headRow("Recommended for you 😍").paddingHorizontal(16).marginDown(),
            // SizedBox(
            //   height: productTileHeight,
            //   child: productsListHorizontal(),
            // ).marginLeft(16).marginDown(),
            // headRow("Best Selling Cakes 🍰").marginLeftRight(16).marginDown(),
            // SizedBox(
            //   height: productTileHeight,
            //   child: productsListHorizontal(),
            // ).marginLeft(16).marginDown(),
            // headRow("Trending Cakes 😍").marginLeftRight(16).marginDown(),
            // SizedBox(
            //   height: productTileHeight,
            //   child: productsListHorizontal(),
            // ).marginLeft(16).marginDown(),
          ]);
        }));
  }

  ListView productsListHorizontal() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ProductTileHome(
          imageUrl: 'assets/images/home/cake_2.png',
          title: "BlackForest Cake ",
          discountedPrice: "\$300",
          actualPrice: "\$500",
        ).marginRight(8),
        ProductTileHome(
          imageUrl: 'assets/images/home/cake_2.png',
          title: "BlackForest Cake ",
          discountedPrice: "\$300",
          actualPrice: "\$500",
        ).marginRight(8),
        ProductTileHome(
          imageUrl: 'assets/images/home/cake_2.png',
          title: "BlackForest Cake ",
          discountedPrice: "\$300",
          actualPrice: "\$500",
        ).marginRight(8),
        ProductTileHome(
          imageUrl: 'assets/images/home/cake_2.png',
          title: "BlackForest Cake ",
          discountedPrice: "\$300",
          actualPrice: "\$500",
        ).marginRight(8),
      ],
    );
  }

  Material productTile(String imageUrl, String title, String discountedPrice,
      String actualPrice) {
    return Material(
      elevation: 1,
      color: DesignColor.white,
      borderRadius: BorderRadius.circular(10),
      borderOnForeground: false,
      type: MaterialType.card,
      child: SizedBox(
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
                child: Container(
                    alignment: Alignment.topRight,
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.only(right: 2, top: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: DesignColor.green),
                          borderRadius: BorderRadius.circular(8),
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
                        child: "16% OFF".textSmall(DesignColor.black)))),
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

  Container categoryTile(BuildContext context, String imageUrl, String title) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: 100,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(imageUrl),
      )),
      child: title.textLargeBold(DesignColor.white),
    );
  }

  Widget flashSaleWidget(HomeProductModel homeMainModel) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: const Alignment(-1.548, -2.134),
        end: const Alignment(1.548, 3.607),
        colors: [DesignColor.greenGradientStart, DesignColor.greenGradientEnd],
        stops: const <double>[0, 1],
      )),
      // height: flashSaleHeight,
      child: Column(children: [
        headRow("Flash Sale", DesignColor.black).marginDown().marginRight(),
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: flashSaleTileHeight,
              child: ListView.builder(
                itemCount: homeMainModel.products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return flashSaleTile(
                          image: homeMainModel.products[index].images[0].url,
                          discount: homeMainModel
                              .products[index].primaryDiscountedRate
                              ?.toInt(),
                          title: homeMainModel.products[index].name)
                      .marginRight(8);
                },
              ),
            ))
      ]),
    );
  }

  /// alert: check if the discount is null or ""

  Widget flashSaleTile(
      {required String image, int? discount, required String title}) {
    // return Container(
    //   // color: Colors.red,

    //   width: flashSaleTileWidth,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(10),
    //       image: const DecorationImage(
    //           fit: BoxFit.cover,
    //           image: AssetImage('assets/images/home/cake.png'))),
    //   child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.end,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Visibility(
    //           visible: discount != 0,
    // child: Container(
    //   margin: const EdgeInsets.only(top: 2, right: 2),
    //   padding: const EdgeInsets.all(2),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     gradient: const LinearGradient(
    //       begin: Alignment(-1.238, -1.313),
    //       end: Alignment(3.464, 3.196),
    //       colors: <Color>[
    //         Color(0xfff9d423),
    //         Color(0xfffc8e3a),
    //         Color(0xffff4e50)
    //       ],
    //       stops: <double>[0.038, 0.5, 0.928],
    //     ),
    //   ),
    //   child: Text("$discount%"),
    // ),
    //         ),
    //         Container(
    //             margin: const EdgeInsets.only(left: 2, bottom: 2),
    //             alignment: Alignment.bottomCenter,
    //             child: title.textLargeRegular(DesignColor.white))
    //       ]),
    // );
    return SizedBox(
      width: flashSaleTileWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          // fadeInDuration: const Duration(milliseconds: 500),
          imageUrl: image,
          // placeholder: (context, url) => Shimmer.fromColors(
          //   // baseColor: Colors.grey[300]!,
          //   baseColor: Colors.grey.shade500,
          //   highlightColor: Colors.grey[100]!,
          //   child: Container(
          //     color: Colors.black.withOpacity(0.4),
          //     child: SvgPicture.asset(
          //       'assets/svg/placeholder.svg',
          //       color: Colors.black,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
          placeholder: (context, url) {
            return Container(
                color: Colors.grey.shade200,
                child: SizedBox(
                  width: double.infinity / 2,
                  height: double.infinity / 2,
                  child: SvgPicture.asset(
                    'assets/svg/placeholder.svg',
                    height: 24,
                    width: 24,
                    color: Colors.grey.shade400,
                  ),
                ));
          },
          height: double.infinity,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Stack(children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover))),
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 2),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: title.textLargeRegular(DesignColor.white)),
            ),
            Visibility(
              visible: discount != 0,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 2, right: 2),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment(-1.238, -1.313),
                      end: Alignment(3.464, 3.196),
                      colors: <Color>[
                        Color(0xfff9d423),
                        Color(0xfffc8e3a),
                        Color(0xffff4e50)
                      ],
                      stops: <double>[0.038, 0.5, 0.928],
                    ),
                  ),
                  child: Text("$discount%"),
                ),
              ),
            )
          ]),
          // color: Colors.black.withOpacity(.4),
        ),
      ),
    );
  }

  Row headRow(String text, [Color? color]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text.textLargeBold(),
        "See All".textMediumBold(color ?? DesignColor.green)
      ],
    );
  }
}

// /// alert : lookUp the products and get it
Widget buildHomeSection(List<dynamic> products) {
  return SizedBox(
    height: 240,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        HomeProductModel productModel = products[index];

        return Container(
          child: Text(productModel.products.toString()),
        );
      },
    ),
  );
}
