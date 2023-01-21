import 'package:flutter/material.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
// ignore: slash_for_doc_comments
/**feature Home can be heading or if there are details you can use 
 * UserAccountsDrawerHeader as well
 * 
 */
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: const Text('Oflutter.com'),
          //   accountEmail: const Text('example@gmail.com'),
          //   currentAccountPicture: CircleAvatar(
          //     child: ClipOval(
          //       child: Image.network(
          //         'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
          //         fit: BoxFit.cover,
          //         width: 90,
          //         height: 90,
          //       ),
          //     ),
          //   ),
          //   decoration: const BoxDecoration(
          //     color: Colors.blue,
          //     image: DecorationImage(
          //         fit: BoxFit.fill,
          //         image: NetworkImage(
          //             'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
          //   ),
          // ),
          Container(
            color: DesignColor.green,
            height: 16 * 8,
            alignment: Alignment.centerLeft,
            child: "Home".appBarText().marginLeft(16).marginTop(),
          ),
          /**alert: context.pushName() use instead of context.go() */
          ListTile(
            minLeadingWidth: 16,
            horizontalTitleGap: 16,
            leading: const Icon(Icons.account_circle_rounded),
            title: 'My Profile'.textMediumRegular(),
            onTap: () => null,
          ),
          ListTile(
            minLeadingWidth: 16,
            horizontalTitleGap: 16,
            leading: const Icon(Icons.shopping_cart_rounded),
            title: 'My Cart'.textMediumRegular(),
            onTap: () => null,
          ),
          ListTile(
            minLeadingWidth: 16,
            horizontalTitleGap: 16,
            leading: const Icon(Icons.shopping_bag_rounded),
            title: 'My Orders'.textMediumRegular(),
            onTap: () => null,
          ),
          ListTile(
            minLeadingWidth: 16,
            horizontalTitleGap: 16,
            leading: const Icon(Icons.home_rounded),
            title: 'My Address'.textMediumRegular(),
          ),

          ListTile(
            minLeadingWidth: 16,
            horizontalTitleGap: 16,
            leading: const Icon(Icons.logout_rounded),
            title: 'Log out'.textMediumRegular(),
          )
        ],
      ).addWidgetColor(DesignColor.white),
    );
  }
}
