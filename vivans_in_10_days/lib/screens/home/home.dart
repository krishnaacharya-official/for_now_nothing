import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/shimmer_home.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_home.dart';
import 'package:vivans_in_10_days/models/product_model.dart';
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
          if (state is ProductsErrorState) {
            /**attention: change */
            return Text(state.error);
            // return NoDataHelper(
            //     iconData: Icons.warning_amber_rounded,
            //     title: "Internal error occured",
            //     subtitle:
            //         "Seems like your internet connection is poor or unstable. Please check your connection and try again",
            //     buttonTitle: "Retry",
            //     buttonType: ButtonType.filled,
            //     onTap: () {
            //       BlocProvider.of<ProductsCubit>(context).init();
            //     });
          }
          List<dynamic>? homeSpecialProducts = state.homeSpecialProducts;
          List<dynamic>? homeCategoryProducts = state.homeCategoryProducts;
          HomeProductModel homeSpecialPrimary = homeSpecialProducts?[0];
          HomeProductModel homeCategoryPrimary = homeCategoryProducts?[0];
          // debugPrint(homeSpecialModel.image.url);
          return ListView(children: [
            headRow("Special Offers", onTap: () {
              context.pushNamed(Routes.specialOffer,
                  extra: homeSpecialProducts);
            }).marginDown().marginTop().paddingHorizontal(16),
            InkWell(
              onTap: () {
                context.pushNamed(Routes.homeProductList,
                    extra: homeSpecialPrimary,
                    queryParams: {'appBarTitle': "Discount Sale"});
              },
              child: SizedBox(
                height: specialOfferTileHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: homeSpecialPrimary.image.url,
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
                // child:
              ).marginDown().paddingHorizontal(16),
            ),
            flashSaleWidget(homeCategoryPrimary).marginDown(),
            headRow("Categories", onTap: () {
              context.pushNamed(Routes.categoryAll);
            }).paddingHorizontal(16).marginDown(),
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
                          "Designer Cake", () {
                        context.pushNamed(Routes.category,
                            extra: CategoryList.CATEGORY_CUSTOM,
                            queryParams: {'name': "Designer Cakes"});
                      }),
                      categoryTile(
                          context,
                          'assets/images/home/flavored_cake.png',
                          "Flavored Cake", () {
                        context.pushNamed(Routes.category,
                            extra: CategoryList.CATEGORY_FLAVOUR,
                            queryParams: {'name': "Flavored Cakes"});
                      }),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    categoryTile(context, 'assets/images/home/party_cake.png',
                        "Party Cake", () {
                      context.pushNamed(Routes.category,
                          extra: CategoryList.CATEGORY_OCCASION,
                          queryParams: {'name': "Party Cakes"});
                    }),
                    categoryTile(context, 'assets/images/home/snacks.png',
                        "Vivans Special", () {
                      context.pushNamed(Routes.category,
                          extra: CategoryList.CATEGORY_SNACKS,
                          queryParams: {'name': "Vivans Special"});
                    }),
                  ],
                )
              ],
            ).paddingHorizontal(16),
            // buildHomeSection(state.homeCategoryProducts!),
            restWidgetsOfHome(homeCategoryProducts!)
          ]);
        }));
  }

  ListView productsListHorizontal(homeCategoryProduct) {
    HomeProductModel homeProductModel = homeCategoryProduct;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: homeProductModel.products.length > 7
          ? 8
          : homeProductModel.products.length,
      itemBuilder: (context, index) {
        ProductModel productModel = homeProductModel.products[index];
        return ProductTileHome(
                discountRate: productModel.primaryDiscountedRate,
                imageUrl: productModel.images[0].url,
                title: productModel.name,
                discountedPrice: productModel.primaryDiscountedPrice,
                actualPrice: productModel.primaryPrice)
            .marginRight(8);
      },
    );
  }

  InkWell categoryTile(
      BuildContext context, String imageUrl, String title, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imageUrl),
        )),
        child: title.textLargeBold(DesignColor.white),
      ),
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
        headRow("Flash Sale", color: DesignColor.black, onTap: () {
          context.pushNamed(Routes.homeProductList,
              extra: homeMainModel,
              queryParams: {'appBarTitle': homeMainModel.title});
        }).marginDown().marginRight(),
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: SizedBox(
              height: flashSaleTileHeight,
              child: ListView.builder(
                itemCount: homeMainModel.products.length > 7
                    ? 8
                    : homeMainModel.products.length,
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
    return SizedBox(
      width: flashSaleTileWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          // fadeInDuration: const Duration(milliseconds: 500),
          imageUrl: image,
          placeholder: (context, url) {
            return Container(
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

  Row headRow(String text, {Color? color, Function? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text.textLargeBold(),
        InkWell(
            onTap: onTap != null
                ? () {
                    onTap();
                  }
                : () {},
            child: "See All".textMediumBold(color ?? DesignColor.green))
      ],
    );
  }

  Widget restWidgetsOfHome(List homeCategoryProducts) {
    return SizedBox(
      height: (homeCategoryProducts.length - 1) * (productTileHeight + 60),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeCategoryProducts.length - 1,
        itemBuilder: (context, index) {
          HomeProductModel homeProductModel = homeCategoryProducts[index + 1];
          return Column(children: [
            headRow(homeProductModel.title, onTap: () {
              context.pushNamed(Routes.homeProductList,
                  extra: homeProductModel,
                  queryParams: {'appBarTitle': homeProductModel.title});
            }).paddingHorizontal(16).marginDown().marginTop(),
            SizedBox(
              height: productTileHeight,
              child: productsListHorizontal(homeProductModel),
            ).marginLeft(16),
          ]);
        },
      ),
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
