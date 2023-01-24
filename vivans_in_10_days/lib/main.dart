import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';
import 'package:vivans_in_10_days/cubit/products/products_cubit.dart';
import 'package:vivans_in_10_days/helpers/custom_theme.dart';
import 'package:vivans_in_10_days/helpers/miscillenous.dart';
import 'package:vivans_in_10_days/helpers/providers.dart';
import 'package:vivans_in_10_days/router.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var isDialogDisplayed = false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.customTheme(),
    home: MultiBlocProvider(
        providers: Providers.getProviders,
        child: BlocConsumer<ConnectivityCubit, ConnectivityState>(
            listener: (context, state) {
          if (state == ConnectivityState.disconnected) {
            isDialogDisplayed = true;
          }
          if (state == ConnectivityState.connected &&
              isDialogDisplayed == true) {
            BlocProvider.of<ProductsCubit>(context).init();
            isDialogDisplayed = false;
          }
        }, builder: (context, state) {
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
                  ? MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      theme: CustomTheme.customTheme(),
                      routerConfig: router,
                    )
                  : const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
        })),
  ));
}
