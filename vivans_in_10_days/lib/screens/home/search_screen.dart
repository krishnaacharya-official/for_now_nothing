import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:vivans_in_10_days/helpers/widgets/product_tile_search.dart';

class SearchScreenDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final productTileHeight = 16 * 11.5.toDouble();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          "Popular Tags".textLargeBold().marginDown(16),
          Wrap(spacing: 8, children: [
            Chip(
              label: "Butterscoth".textMediumRegular(),
            ),
            Chip(
              label: "Butterscoth".textMediumRegular(),
            ),
            Chip(
              label: "Butterscoth".textMediumRegular(),
            ),
            Chip(
              label: "Butterscoth".textMediumRegular(),
            ),
            Chip(
              label: "Butterscoth".textMediumRegular(),
            )
          ]).marginDown(16),
          "Popular Searches".textLargeBold().marginDown(16),
          SizedBox(
              height: productTileHeight,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ProductTileSearch(
                    imageUrl: 'assets/images/home/cake_2.png',
                    title: "BlackForest Cake ",
                    discountedPrice: "\$300",
                    actualPrice: "\$500",
                  ).marginRight(8),
                  ProductTileSearch(
                    imageUrl: 'assets/images/home/cake_2.png',
                    title: "BlackForest Cake ",
                    discountedPrice: "\$300",
                    actualPrice: "\$500",
                  ).marginRight(8),
                  ProductTileSearch(
                    imageUrl: 'assets/images/home/cake_2.png',
                    title: "BlackForest Cake ",
                    discountedPrice: "\$300",
                    actualPrice: "\$500",
                  ).marginRight(8),
                  ProductTileSearch(
                    imageUrl: 'assets/images/home/cake_2.png',
                    title: "BlackForest Cake ",
                    discountedPrice: "\$300",
                    actualPrice: "\$500",
                  ).marginRight(8),
                ],
              )),
        ]),
      ),
    );
  }
}
