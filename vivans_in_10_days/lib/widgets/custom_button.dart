import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/standards.dart';
import 'package:vivans_in_10_days/design_system/text.dart';

enum WidthType { half, full }

class ButtonFilled extends StatelessWidget {
  final Color? textColor;
  final double? borderRadius;
  final WidthType? width;
  final Text text;
  const ButtonFilled({
    super.key,
    required this.text,
    this.textColor,
    this.borderRadius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Standards.buttonHeight,
        width: width == WidthType.full
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 20))),
        child: text.addColor(textColor));
  }
}

class ButtonHallow extends StatelessWidget {
  final Color? strokeColor;
  final Color? textColor;
  final double? borderRadius;
  final WidthType? width;
  final Text text;
  const ButtonHallow({
    super.key,
    required this.text,
    this.strokeColor,
    this.textColor,
    this.borderRadius,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Standards.buttonHeight,
        width: width == WidthType.full
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: strokeColor ?? Colors.green, width: 2),
            borderRadius:
                BorderRadius.all(Radius.circular(borderRadius ?? 20))),
        child: text.addColor(textColor));
  }
}
