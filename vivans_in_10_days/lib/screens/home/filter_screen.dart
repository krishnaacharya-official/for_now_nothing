// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

/**feature: You can persist the filters for a better user experience */
class _FilterScreenState extends State<FilterScreen> {
  // List<bool?> values = [false, false, false, false, false];
  List<bool?> priceValues = List.filled(5, false);
  List<bool?> tagValues = List.filled(20, false);
  List<Map<String, int>> priceRanges = [
    {"lower": 0, "upper": 500},
    {"lower": 500, "upper": 1000},
    {"lower": 1000, "upper": 1500},
    {"lower": 1500, "upper": 2000},
    {"lower": 2000, "upper": 10000},
  ];
  final List<String> price = [
    "Rs 499 and Below",
    "Rs 500 - Rs 999",
    "Rs 1000 - Rs 1499",
    "Rs 1500 - Rs 1999",
    "Rs 2000 - Above"
  ];
  final List<String> tags = [
    Constants.TAG_CHOCLATE,
    Constants.TAG_BLACKFOREST,
    Constants.TAG_WHITEFOREST,
    Constants.TAG_VANILLA,
    Constants.TAG_BUTTERSCOTCH,
    Constants.TAG_STRAWBERRY,
    Constants.TAG_REDVELVET,
    Constants.TAG_MANGO,
    Constants.TAG_PINEAPPLE,
    Constants.TAG_BLACKCURRENT,
    Constants.TAG_ORANGE,
    Constants.TAG_FRUITFILLINGS,
    Constants.TAG_TRUFFLES,
    Constants.TAG_PHOTOCAKE,
    Constants.TAG_DESIGNER,
    Constants.TAG_CARTOON,
    Constants.TAG_BIRTHDAY,
    Constants.TAG_ANNIVERSARY,
    Constants.TAG_SNACKS,
    Constants.TAG_ADDONS,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Filter".appBarText(),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            /**alert: when internet is off */
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Price Range".textLargeBold().marginLeft(8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: price.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 16 * 2.5,
                        child: CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: price[index].textMediumRegular(),
                            value: priceValues[index],
                            onChanged: (val) {
                              setState(() {
                                priceValues[index] = val;
                              });
                            }),
                      );
                    },
                  )
                ],
              ).marginDown(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Tags".textLargeBold().marginLeft(8),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 16 * 2.5,
                        child: CheckboxListTile(
                            contentPadding: const EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: tags[index].textMediumRegular(),
                            value: tagValues[index],
                            onChanged: (val) {
                              setState(() {
                                tagValues[index] = val;
                              });
                            }),
                      );
                    },
                  )
                ],
              )
            ],
          ).paddingAll(16),
        ),
        bottomNavigationBar: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 16, top: 16, bottom: 16, right: 8),
              width: MediaQuery.of(context).size.width / 2,
              child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    side: MaterialStateProperty.all(
                        BorderSide(color: DesignColor.orange)),
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.orange.withOpacity(.1);
                      }
                      return Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      // print(
                      //     "Value 0 and 5 ${priceValues[5]} ${priceValues[0]}");
                      priceValues.fillRange(0, 5, false);
                      tagValues.fillRange(0, 20, false);
                    });
                  },
                  child: "Clear All".textLargeBold(DesignColor.orange)),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 8, bottom: 16, top: 16, right: 16),
              width: MediaQuery.of(context).size.width / 2,
              child: OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(DesignColor.white),
                    backgroundColor:
                        MaterialStateProperty.all(DesignColor.orange),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    side: MaterialStateProperty.all(
                        BorderSide(color: DesignColor.orange)),
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.orange.withOpacity(.1);
                      }
                      return Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    List<Map<String, int>> selectedPriceRange = [];
                    List<String> selectedTags = [];
                    for (var index = 0; index < priceValues.length; index++) {
                      if (priceValues[index] == true) {
                        selectedPriceRange.add(priceRanges[index]);
                      }
                    }
                    for (var index = 0; index < tagValues.length; index++) {
                      if (tagValues[index] == true) {
                        selectedTags.add(tags[index]);
                      }
                    }

                    BlocProvider.of<ProductsCubit>(context)
                        .fetchFilteredProducts(
                            selectedPriceRange, selectedTags);
                    // context.goNamed(Routes.category);
                    /**attention: popping here */
                    context.pop();
                  },
                  child: "Apply".textLargeBold(DesignColor.white)),
            ),
          ],
        ));
  }
}
