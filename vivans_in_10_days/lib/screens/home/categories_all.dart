import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/constants.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class CategoriesAll extends StatelessWidget {
  const CategoriesAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Categories".appBarText(),
        leading: IconButton(
            onPressed: () {
              /**alert: Make sure instead of using pop you use go to the previous page
               * Because when the internet switches off and on , no navigation stack is preserved
               */
              context.goNamed(Routes.home);
            },
            icon: const Icon(Icons.navigate_before)),
      ),
      body: ListView(children: [
        InkWell(
          onTap: () => context.pushNamed(Routes.category,
              extra: CategoryList.CATEGORY_CUSTOM),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/home/category1.png'))
              .marginDown(),
        ),
        InkWell(
          onTap: () => context.pushNamed(Routes.category,
              extra: CategoryList.CATEGORY_FLAVOUR),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/home/category2.png'))
              .marginDown(),
        ),
        InkWell(
          onTap: () => context.pushNamed(Routes.category,
              extra: CategoryList.CATEGORY_OCCASION),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/home/category3.png'))
              .marginDown(),
        ),
        InkWell(
          onTap: () => context.pushNamed(Routes.category,
              extra: CategoryList.CATEGORY_SPECIALONE),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/home/category4.png'))
              .marginDown(),
        ),
        InkWell(
          onTap: () => context.pushNamed(Routes.category,
              extra: CategoryList.CATEGORY_VIVANSSPECIAL),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/home/category5.png'))
              .marginDown(),
        ),
        InkWell(
          onTap: () => context.pushNamed(Routes.category,
              extra: CategoryList.CATEGORY_SNACKS),
          child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/home/category6.png'))
              .marginDown(),
        ),
      ]).paddingAll(16),
    );
  }
}
