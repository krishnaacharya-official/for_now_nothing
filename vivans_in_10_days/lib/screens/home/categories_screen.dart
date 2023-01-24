import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/miscillenous.dart';
import 'package:vivans_in_10_days/helpers/shimmer_grid.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_category.dart';

class CategoriesScreen extends StatefulWidget {
  CategoryList category;
  CategoriesScreen({super.key, required this.category});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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

        title: getCategory(widget.category).appBarText(),
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
              context.goNamed(Routes.home);
            },
            icon: const Icon(Icons.navigate_before)),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          size = MediaQuery.of(context).size;
          // childWidth = (size.width / 2);
          // childHeight = (size.height / 3);
          /**alert: I am having doubt with this hard coded value */
          // childHeight = childWidth * 1.3;
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
              // childAspectRatio: ((childWidth / childHeight)),
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
    );
  }
}
/**alert: Snacks doesn't have anything : Say products not found  */