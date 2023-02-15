import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_state.dart';
import 'package:vivans_in_10_days/cubit/users/user_cubit.dart';
import 'package:vivans_in_10_days/cubit/users/user_state.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/extensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.grey,
      appBar: AppBar(
        title: "Profile".appBarText().marginLeft(16),
        backgroundColor: DesignColor.green,
      ),
      body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: DesignColor.green,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(state.userModel?.avatar ==
                                          "boy"
                                      ? 'assets/images/avatars/boy.png'
                                      : state.userModel?.avatar == "girl"
                                          ? "assets/images/avatars/girl.png"
                                          : "assets/images/avatars/user_1.png"))),
                          child: Container()),
                      state.userModel?.fullName
                              .textLargeBold(DesignColor.white)
                              .marginTop() ??
                          Container(),
                      FirebaseAuth.instance.currentUser?.phoneNumber
                              ?.textLargeBold(DesignColor.white)
                              .marginTop(16)
                              .marginDown(16) ??
                          state.userModel?.phoneNumber
                              .textLargeBold(DesignColor.white)
                              .marginTop(8)
                              .marginDown(16) ??
                          Container().marginTop(8)
                    ],
                  ).paddingAll(16),
                ),
                Column(
                  children: [
                    profileTile(
                        "My Profile", const Icon(Icons.account_circle_rounded),
                        () {
                      context.pushNamed(Routes.profileMine);
                    }).marginDown(),
                    profileTile(
                        "My Cart", const Icon(Icons.shopping_cart_rounded), () {
                      context.pushNamed(Routes.cart);
                    }).marginDown(),
                    /**alert Change this route */
                    profileTile(
                        "My Orders", const Icon(Icons.shopping_bag_rounded),
                        () {
                      context.pushNamed(Routes.cart);
                    }).marginDown(),
                    profileTile("My Address", const Icon(Icons.home_rounded),
                        () {
                      context.pushNamed(Routes.addressMine);
                    }).marginDown(),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoggedOutState) {
                          // Navigator.popUntil(context, (route) => route.isFirst);
                          context.goNamed(Routes.signIn);
                        }
                      },
                      builder: (context, state) => ListTile(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).logOut();
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        tileColor: DesignColor.white,
                        leading: Icon(
                          Icons.logout_rounded,
                          color: DesignColor.red,
                        ),
                        title: "Log out"
                            .textMediumBold()
                            .addColor(DesignColor.red),
                      ),
                    )
                  ],
                ).paddingAll(16),
              ],
            ),
          ),
        );
      }),
    );
  }

  ListTile profileTile(String text, Icon icon, Function onTap) {
    return ListTile(
      onTap: () => onTap(),
      style: ListTileStyle.drawer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      tileColor: DesignColor.white,
      leading: icon,
      title: text.textMediumBold(),
      trailing: const Icon(Icons.navigate_next),
    );
  }
}
