// import 'package:vivans_in_10_days/app_routes.dart';
// import 'package:vivans_in_10_days/bloc/auth/auth_cubit.dart';
// import 'package:vivans_in_10_days/bloc/auth/auth_state.dart';
// import 'package:vivans_in_10_days/data/models/user_address.dart';
// import 'package:vivans_in_10_days/screens/home/cart_screen.dart';
// import 'package:vivans_in_10_days/screens/home/details_screen.dart';
// import 'package:vivans_in_10_days/screens/home/home.dart';
// import 'package:vivans_in_10_days/screens/home/main_home.dart';
// import 'package:vivans_in_10_days/screens/phoneAuth/otp_screen.dart';
// import 'package:vivans_in_10_days/screens/phoneAuth/sign_in.dart';
// import 'package:vivans_in_10_days/screens/profile/add_address.dart';
// import 'package:vivans_in_10_days/screens/profile/my_address.dart';
// import 'package:vivans_in_10_days/screens/profile/my_profile.dart';
// import 'package:vivans_in_10_days/screens/profile/profile_%20main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vivans_in_10_days/app_routes.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_state.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';
import 'package:vivans_in_10_days/helpers/miscillenous.dart';
import 'package:vivans_in_10_days/models/address_model.dart';
import 'package:vivans_in_10_days/screens/home/bottom_navigation_home.dart';
import 'package:vivans_in_10_days/screens/home/cart_screen.dart';
import 'package:vivans_in_10_days/screens/home/details_screen.dart';
import 'package:vivans_in_10_days/screens/home/home.dart';
import 'package:vivans_in_10_days/screens/phoneAuth/otp_screen.dart';
import 'package:vivans_in_10_days/screens/phoneAuth/sign_in.dart';
import 'package:vivans_in_10_days/screens/profile/add_address.dart';
import 'package:vivans_in_10_days/screens/profile/my_address.dart';
import 'package:vivans_in_10_days/screens/profile/my_profile.dart';
import 'package:vivans_in_10_days/screens/profile/profile_%20main.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: "/",
      builder: (context, state) {
        bool isDialogDisplayed = false;
        return BlocConsumer<ConnectivityCubit, ConnectivityState>(
          listener: (context, state) {
            if (state == ConnectivityState.disconnected) {
              isDialogDisplayed = true;
            }
            if (state == ConnectivityState.connected &&
                isDialogDisplayed == true) {
              isDialogDisplayed = false;
            }
          },
          builder: (context, state) {
            if (state == ConnectivityState.init) {
              return const Scaffold(
                  body: CircularProgressIndicator()); // Shimmer home
            }
            return isDialogDisplayed
                ? Scaffold(
                    body: NoDataHelper(
                        title: "No Connection",
                        subtitle:
                            "Please check your internet connection and Try again",
                        buttonTitle: "Retry",
                        buttonType: ButtonType.filled,
                        iconData: Icons.wifi_off_outlined,
                        onTap: () {}),
                  )
                : state == ConnectivityState.connected
                    ? BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (oldState, newState) {
                          return oldState is AuthInitialState;
                          //  ||                oldState is AuthLoggedOutState // oTP Screen willl not be shown;
                        },
                        builder: (context, state) {
                          if (state is AuthLoggedInState) {
                            print("I am inside authlogged in");
                            return const MainHomeScreen();
                            // return const MyAddress();
                          } else {
                            print("I am side authlogged out");
                            return SignIn();
                          }
                        },
                      )
                    : const Scaffold(
                        body: Center(
                            child:
                                CircularProgressIndicator())); /**alert: Add shimmer container here */
          },
        );
      }),
  GoRoute(
      path: '/homeMain',
      name: Routes.homeMain,
      builder: (context, state) => const MainHomeScreen()),
  GoRoute(
      name: Routes.home,
      path: '/home',
      builder: (context, state) => const Home()),
  GoRoute(
      name: Routes.details,
      path: '/details',
      builder: (context, state) => DetailsScreen(
            sample: state.queryParams[0]!,
          )),
  GoRoute(
      path: '/otpScreen/:id',
      name: Routes.otpScreen,
      builder: (context, state) => OtpScreen(number: state.params['id']!)),
  GoRoute(
      path: '/cart',
      name: Routes.cart,
      builder: (context, state) => CartScreen()),
  GoRoute(
      name: Routes.signIn,
      path: '/signIn',
      builder: (context, state) => SignIn(number: state.queryParams['number'])),
  GoRoute(
      path: '/profile',
      name: Routes.profileMain,
      builder: (context, state) => const ProfileScreen()),
  GoRoute(
      path: '/profileMine',
      name: Routes.profileMine,
      builder: (context, state) => const MyProfileScreen()),
  GoRoute(
      path: '/address',
      name: Routes.addressMine,
      builder: (context, state) => const MyAddress()),
  GoRoute(
      path: '/addAddress',
      name: Routes.addressAdd,
      builder: (context, state) => state.queryParams.isNotEmpty
          ? AddAddress(address: AddressModel.fromJsonString(state.queryParams))
          : AddAddress())
]);
