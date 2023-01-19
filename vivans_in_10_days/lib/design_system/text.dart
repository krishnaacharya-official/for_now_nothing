import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';

extension TextThemeb on String {
  Text text() {
    return Text(
      this,
      style: const TextStyle(),
    );
  }

  Text appBarText([Color? inputColor]) {
    return Text(this,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: inputColor ?? DesignColor.primaryTextColor));
    // ?.copyWith(color: Colors.red, fontFamily: 'Poppins'));
  }

  Text textLargeBold([Color? inputColor]) {
    return Text(
      this,
      style: textStyleLargeBold(inputColor),
    );
  }

  Text textLargeRegular([Color? inputColor]) {
    return Text(
      this,
      style: textStyleLargeRegular(inputColor),
    );
  }

  Text textLargeThin([Color? inputColor]) {
    return Text(
      this,
      style: textStyleLargeThin(inputColor),
    );
  }

  Text textMediumBold([Color? inputColor]) {
    return Text(
      this,
      style: textStyleMediumBold(inputColor),
    );
  }

  Text textMediumRegular([Color? inputColor]) {
    return Text(
      this,
      style: textStyleMediumRegular(inputColor),
    );
  }

  Text textMediumThin([Color? inputColor]) {
    return Text(
      this,
      style: textStyleMediumThin(inputColor),
    );
  }

  Text textSmall([Color? inputColor]) {
    return Text(
      this,
      style: textStyleSmall(inputColor),
    );
  }
}

TextStyle textStyleSmall([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: inputColor ?? DesignColor.primaryTextColor);
}

TextStyle textStyleMediumThin([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: inputColor ?? DesignColor.primaryTextColor);
}

TextStyle textStyleMediumRegular([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: inputColor ?? DesignColor.primaryTextColor);
}

TextStyle textStyleMediumBold([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: inputColor ?? DesignColor.primaryTextColor);
}

TextStyle textStyleLargeThin([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: inputColor ?? DesignColor.primaryTextColor);
}

TextStyle textStyleLargeRegular([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: inputColor ?? DesignColor.primaryTextColor);
}

TextStyle textStyleLargeBold([Color? inputColor]) {
  return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: inputColor ?? DesignColor.primaryTextColor);
}

extension Themeb on Text {
  Text addColor([Color? color]) {
    return Text(data!, style: style?.copyWith(color: color ?? Colors.black));
  }

  Text red() {
    return Text(data!, style: style?.copyWith(color: Colors.red));
  }

  Text bigFont() {
    return Text(
      data!,
      style: style?.copyWith(fontSize: 22),
    );
  }

  Text boldFont() {
    return Text(
      data!,
      // style: const TextStyle(fontWeight: FontWeight.bold),
      style: style?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
