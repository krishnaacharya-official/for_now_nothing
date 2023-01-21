import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class CartScreen extends StatefulWidget {
  String? sample;
  CartScreen({super.key, this.sample});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<String> items = ['1', "2", "3", "4", "5"];
  String? selectedValue = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Shopping Cart".appBarText(),
        leading: const Icon(Icons.navigate_before),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: DesignColor.white),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/home/cake_2.png'))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Blackforest Cake".textLargeRegular().marginDown(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      "\$300".textLargeBold().marginRight(8),
                      Text(
                        "\$400",
                        style: textStyleMediumRegular()
                            .copyWith(decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ).marginDown(8),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      selectedItemBuilder: (context) {
                        return items.map<Widget>((String item) {
                          return Container(
                            alignment: Alignment.center,
                            // color: Colors.green,
                            child: Text(
                              'Qty: $item',
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList();
                      },
                      hint: Row(
                        children: [
                          // Icon(
                          //   Icons.list,
                          //   size: 16,
                          //   color: Colors.yellow,
                          // ),
                          // SizedBox(
                          //   width: 4,
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     'Select Item',
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.yellow,
                          //     ),
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          "Qty: 1".textSmall(),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: textStyleSmall(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                      ),
                      iconSize: 24,
                      // iconEnabledColor: Colors.yellow,
                      // iconDisabledColor: Colors.grey,
                      buttonHeight: 24,
                      buttonWidth: 74,
                      buttonPadding: const EdgeInsets.only(left: 4, right: 4),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: DesignColor.grey,
                      ),
                      // buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      // dropdownMaxHeight: 200,
                      // dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(14),
                        color: DesignColor.grey,
                      ),
                      // dropdownElevation: 8,
                      // scrollbarRadius: const Radius.circular(40),
                      // scrollbarThickness: 6,
                      // scrollbarAlwaysShow: true,
                      // offset: const Offset(-20, 0),
                    ),
                  ),
                ],
              ).marginLeft(16),
            ),
            Icon(
              Icons.delete_rounded,
              color: DesignColor.red,
            )
          ]),
        ).marginDown(8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: DesignColor.white),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/home/cake_2.png'))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Blackforest Cake".textLargeRegular().marginDown(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      "\$300".textLargeBold().marginRight(8),
                      Text(
                        "\$400",
                        style: textStyleMediumRegular()
                            .copyWith(decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ).marginDown(8),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      selectedItemBuilder: (context) {
                        return items.map<Widget>((String item) {
                          return Container(
                            alignment: Alignment.center,
                            // color: Colors.green,
                            child: Text(
                              'Qty: $item',
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList();
                      },
                      hint: Row(
                        children: [
                          // Icon(
                          //   Icons.list,
                          //   size: 16,
                          //   color: Colors.yellow,
                          // ),
                          // SizedBox(
                          //   width: 4,
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     'Select Item',
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.yellow,
                          //     ),
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                          "Qty: 1".textSmall(),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: textStyleSmall(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                      ),
                      iconSize: 24,
                      // iconEnabledColor: Colors.yellow,
                      // iconDisabledColor: Colors.grey,
                      buttonHeight: 24,
                      buttonWidth: 74,
                      buttonPadding: const EdgeInsets.only(left: 4, right: 4),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: DesignColor.grey,
                      ),
                      // buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      // dropdownMaxHeight: 200,
                      // dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(14),
                        color: DesignColor.grey,
                      ),
                      // dropdownElevation: 8,
                      // scrollbarRadius: const Radius.circular(40),
                      // scrollbarThickness: 6,
                      // scrollbarAlwaysShow: true,
                      // offset: const Offset(-20, 0),
                    ),
                  ),
                ],
              ).marginLeft(16),
            ),
            Icon(
              Icons.delete_rounded,
              color: DesignColor.red,
            )
          ]),
        )
      ]).paddingAll(16),
      bottomNavigationBar: Material(
        elevation: 1,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Flexible(
            flex: 1,
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.vertical,
              children: [
                "Total Amount".textMediumRegular(),
                "\$300".textLargeBold()
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: DesignColor.yellow,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {},
                    child: "Place Order".textLargeBold()),
              ))
        ]).paddingAll(16),
      ),
    );
  }
}
