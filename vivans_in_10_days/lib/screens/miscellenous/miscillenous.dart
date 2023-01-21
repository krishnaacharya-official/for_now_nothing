import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';
import 'package:flutter/material.dart';

enum ButtonType { outline, filled }

class NoDataHelper extends StatelessWidget {
  IconData iconData;
  String title;
  ButtonType buttonType;
  String buttonTitle;
  Function onTap;
  NoDataHelper({
    super.key,
    required this.iconData,
    required this.title,
    required this.buttonTitle,
    required this.buttonType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print("Icon data is $iconData");
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: DesignColor.green.withOpacity(.2)),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  iconData,
                  color: DesignColor.darkGreen,
                  size: MediaQuery.of(context).size.width / 4,
                ),
              ),
            ).marginDown(32),
            "No Address".textLargeBold().marginDown(32),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: buttonType == ButtonType.outline
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: DesignColor.green)),
                      onPressed: () {
                        onTap();
                      },
                      child: buttonTitle.textLargeBold(DesignColor.green))
                  : FilledButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: DesignColor.green)),
                      onPressed: () {
                        onTap();
                      },
                      child: buttonTitle.textLargeBold(DesignColor.white)),
            )
          ]),
    );
  }
}
