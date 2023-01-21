import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<bool?> values = [false, false, false, false, false];
  final String rangeBelow = "Rs 499 and Below";
  final String range999 = "Rs 500 - Rs 999";
  final String range1499 = "Rs 1000 - Rs 1499";
  final String range1999 = "Rs 1500 - Rs 1999";
  final String rangeAbove = "Rs 2000 - Above";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: "Filter".appBarText(),
          leading: const Icon(Icons.close_rounded),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Price Range".textLargeBold().marginLeft(8),
                SizedBox(
                  height: 16 * 2.5,
                  child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: rangeBelow.textMediumRegular(),
                      value: values[0],
                      onChanged: (val) {
                        setState(() {
                          values[0] = val;
                        });
                      }),
                ),
                SizedBox(
                  height: 16 * 2.5,
                  child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: range999.textMediumRegular(),
                      value: values[1],
                      onChanged: (val) {
                        setState(() {
                          values[1] = val;
                        });
                      }),
                ),
                SizedBox(
                  height: 16 * 2.5,
                  child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: range1499.textMediumRegular(),
                      value: values[2],
                      onChanged: (val) {
                        setState(() {
                          values[2] = val;
                        });
                      }),
                ),
                SizedBox(
                  height: 16 * 2.5,
                  child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: range1999.textMediumRegular(),
                      value: values[3],
                      onChanged: (val) {
                        setState(() {
                          values[3] = val;
                        });
                      }),
                ),
                SizedBox(
                  height: 16 * 2.5,
                  child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: rangeAbove.textMediumRegular(),
                      value: values[4],
                      onChanged: (val) {
                        setState(() {
                          values[4] = val;
                        });
                      }),
                )
              ],
            ).marginDown(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Tags".textLargeBold().marginLeft(8),
                SizedBox(
                  height: 16 * 2.5,
                  child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: "ButterScoth".textMediumRegular(),
                      value: values[0],
                      onChanged: (val) {
                        setState(() {
                          // values[0] = val;
                        });
                      }),
                ),
              ],
            )
          ],
        ).paddingAll(16),
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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: "Apply".textLargeBold(DesignColor.white)),
            ),
          ],
        ));
  }
}
