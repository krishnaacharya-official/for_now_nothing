import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/miscillenous.dart';
import 'package:vivans_in_10_days/helpers/shimmer_grid.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_category.dart';

class CategoriesScreen extends StatefulWidget {
  CategoryList category;
  String? title;
  CategoriesScreen({super.key, required this.category, this.title});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String id = "Relevance";
  void _showModalSheet() {
    showModalBottomSheet<dynamic>(
        backgroundColor: DesignColor.white,
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, setState) {
            return Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  "Sort by".textLargeBold().marginLeft(8),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: "Relevance".textMediumRegular(),
                    groupValue: id,
                    value: "Relevance",
                    onChanged: (val) {
                      setState(() {
                        id = val.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: "Price- Low to High".textMediumRegular(),
                    groupValue: id,
                    value: "Price- Low to High",
                    onChanged: (val) {
                      setState(() {
                        id = val.toString();
                      });
                      BlocProvider.of<ProductsCubit>(context)
                          .fetchCategoryProductsAscDesc(
                              getCategory(widget.category), true);
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: "Price- High to Low".textMediumRegular(),
                    groupValue: id,
                    value: "Price- High to Low",
                    onChanged: (val) {
                      setState(() {
                        id = val.toString();
                      });
                      BlocProvider.of<ProductsCubit>(context)
                          .fetchCategoryProductsAscDesc(
                              getCategory(widget.category), false);
                      Navigator.pop(context);
                    },
                  )
                ]).paddingAll(16);
          });
        });
  }

  late Size size;
  late double childWidth;
  late double childHeight;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context)
        .fetchCategoryProducts(getCategory(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: "Recommended For You".appBarText(),

        title: widget.title?.appBarText() ??
            getCategory(widget.category).appBarText(),
        leading: IconButton(
            onPressed: () {
              /**alert: Make sure instead of using pop you use go to the previous page
               * Because when the internet switches off and on , no navigation stack is preserved
               */
              /**As this screen will be used by many elements i can't redirect to particular page, 
               * I can either directly redirect to home page , or pop() 
               * just take care of the internet function.
               */
              // context.pop();
              context.goNamed(Routes.homeMain);
            },
            icon: const Icon(Icons.navigate_before)),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          size = MediaQuery.of(context).size;
          if (state is ProductsErrorState) {
            return NoDataHelper(
                iconData: Icons.warning_amber_rounded,
                title: "Internal error occured",
                subtitle:
                    "Seems like your internet connection is poor or unstable. Please check your connection and try again",
                buttonTitle: "Retry",
                buttonType: ButtonType.filled,
                onTap: () {
                  BlocProvider.of<ProductsCubit>(context).init();
                });
          }
          if (state is ProductsLoading) {
            return Scaffold(body: ShimmerGrid());
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: state.mainCategoryProducts?.length,
            itemBuilder: (context, index) {
              var product = state.mainCategoryProducts?[index];
              return ProductTileCategory(
                imageUrl: product.images[0].url,
                title: product.name,
                discountedPrice: product.primaryDiscountedPrice,
                actualPrice: product.primaryPrice,
                discountRate: product.primaryDiscountedRate,
              );
            },
          ).paddingAll(16);
        },
      ),
      bottomNavigationBar: Material(
        elevation: 1,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: _showModalSheet,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.sort_rounded).marginRight(8),
                    "Sort".textLargeBold()
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(Routes.filter);
            },
            child: Container(
              padding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.filter_list_rounded).marginRight(8),
                    "Filter".textLargeBold()
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
/**alert: Snacks doesn't have anything : Say products not found  */