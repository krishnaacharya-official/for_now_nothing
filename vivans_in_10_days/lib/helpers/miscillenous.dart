import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

enum ButtonType { outline, filled }

class NoDataHelper extends StatelessWidget {
  //  String? svgAsset;
  dynamic iconData;
  String title;
  String? subtitle;
  ButtonType buttonType;
  String buttonTitle;
  Function onTap;
  NoDataHelper({
    super.key,
    required this.iconData,
    this.subtitle,
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
                child: iconData.runtimeType == IconData
                    ? Icon(
                        iconData,
                        color: DesignColor.darkGreen,
                        size: MediaQuery.of(context).size.width / 4,
                      )
                    : SvgPicture.asset(
                        iconData,
                        color: DesignColor.darkGreen,
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.width / 4,
                      ),
              ),
            ).marginDown(32),
            title.textLargeBold().marginDown(32),
            subtitle != null
                ? Text(
                    subtitle!,
                    style: textStyleMediumRegular(),
                    textAlign: TextAlign.center,
                  ).marginDown(32).paddingHorizontal(48)
                : Container(),
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
