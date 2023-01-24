// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_category.dart';
import 'package:vivans_in_10_days/models/products_main_model.dart';

/**alert: Use Staggered GridView */
/**https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/ */

class HomeProductsList extends StatefulWidget {
  HomeProductModel homeProductModel;
  String? appBarTitle;
  bool showSortFilter;
  HomeProductsList(
      {super.key,
      required this.homeProductModel,
      this.appBarTitle,
      required this.showSortFilter});

  @override
  State<HomeProductsList> createState() => _HomeProductsListState();
}

class _HomeProductsListState extends State<HomeProductsList> {
  final productTileHeight = 16 * 16.toDouble();
  void _showModalSheet() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          String id = "Relevance";
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
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    childWidth = (size.width / 2);

    /**alert: I am having doubt with this hard coded value */
    childHeight = childWidth * 1.3;
    return Scaffold(
      appBar: AppBar(
        // title: "Recommended For You".appBarText(),

        title: widget.appBarTitle?.appBarText() ?? "Products".appBarText(),
        leading: IconButton(
            onPressed: () {
              /**alert: Make sure instead of using pop you use go to the previous page
               * Because when the internet switches off and on , no navigation stack is preserved
               */
              /**As this screen will be used by many elements i can't redirect to particular page, 
               * I can either directly redirect to home page , or pop() 
               * just take care of the internet function.
               */
              context.pop();
            },
            icon: const Icon(Icons.navigate_before)),
        /**alert: work */
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: ((childWidth / childHeight)),
        ),
        itemCount: widget.homeProductModel.products.length,
        itemBuilder: (context, index) {
          var product = widget.homeProductModel.products[index];
          return ProductTileCategory(
            imageUrl: product.images[0].url,
            title: product.name,
            discountedPrice: product.primaryDiscountedPrice,
            actualPrice: product.primaryPrice,
            discountRate: product.primaryDiscountedRate,
          );
        },
      ).paddingAll(8),

      // GridView(
      //   shrinkWrap: true,
      //   gridDelegate:
      //   children: <Widget>[
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //     ProductTileCategory(
      //       imageUrl: 'assets/images/home/cake_2.png',
      //       title: "BlackForest Cake ",
      //       discountedPrice: "\$300",
      //       actualPrice: "\$500",
      //     ),
      //   ],
      // ).paddingAll(16),
      bottomNavigationBar: Visibility(
        visible: widget.showSortFilter,
        child: Material(
          elevation: 1,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
              onTap: _showModalSheet,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 8, top: 16, bottom: 16, right: 8),
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
              ).addWidgetColor(Colors.amber),
            ),
            Container(
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
            ).addWidgetColor(Colors.green)
          ]),
        ),
      ),
    );
  }
}
