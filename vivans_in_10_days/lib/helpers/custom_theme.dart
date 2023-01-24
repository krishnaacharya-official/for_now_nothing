import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';

class CustomTheme {
  static ThemeData customTheme() {
    return ThemeData(
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all<Color>(DesignColor.blue),
            checkColor: MaterialStateProperty.all(DesignColor.white)),
        // listTileTheme: ListTileThemeData(selectedColor: DesignColor.blue),
        scaffoldBackgroundColor: DesignColor.grey,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: DesignColor.black),
            titleSpacing: 0),
        useMaterial3: true,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: textStyleMediumRegular(),
          border: const OutlineInputBorder(),
        ),
        // buttonBarTheme: const ButtonBarThemeData(buttonHeight: 56),
        filledButtonTheme: FilledButtonThemeData(
            style:
                FilledButton.styleFrom(minimumSize: const Size.fromHeight(48))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48))),
        colorScheme: ColorScheme.fromSeed(
            seedColor: DesignColor.green,
            primary: DesignColor.green,
            onPrimary: DesignColor.primaryTextColor,
            secondary: DesignColor.yellow,
            onSecondary: DesignColor.white));
  }
}
