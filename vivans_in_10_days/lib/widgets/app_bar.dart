import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class CustomAppBarWithoutIcon extends StatelessWidget with PreferredSizeWidget {
  final String text;

  CustomAppBarWithoutIcon({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextStyleTitleLarge(text),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarWithIcon extends StatelessWidget with PreferredSizeWidget {
  final String text;
  final IconData icon;

  CustomAppBarWithIcon({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      leading: Icon(icon),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
