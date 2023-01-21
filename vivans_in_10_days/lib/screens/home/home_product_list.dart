// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_category.dart';

/**alert: Use Staggered GridView */
/**https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/ */

class HomeProductsList extends StatefulWidget {
  const HomeProductsList({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Recommended For You".appBarText(),
        leading: const Icon(Icons.navigate_before),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisExtent: MediaQuery.of(context).size.height / 3,
            childAspectRatio: 0.8),
        children: <Widget>[
          ProductTileCategory(
            imageUrl: 'assets/images/home/cake_2.png',
            title: "BlackForest Cake ",
            discountedPrice: "\$300",
            actualPrice: "\$500",
          ),
          ProductTileCategory(
            imageUrl: 'assets/images/home/cake_2.png',
            title: "BlackForest Cake ",
            discountedPrice: "\$300",
            actualPrice: "\$500",
          ),
          ProductTileCategory(
            imageUrl: 'assets/images/home/cake_2.png',
            title: "BlackForest Cake ",
            discountedPrice: "\$300",
            actualPrice: "\$500",
          ),
          ProductTileCategory(
            imageUrl: 'assets/images/home/cake_2.png',
            title: "BlackForest Cake ",
            discountedPrice: "\$300",
            actualPrice: "\$500",
          ),
        ],
      ).paddingAll(16),
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
    );
  }
}
