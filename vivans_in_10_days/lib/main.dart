import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';
import 'package:vivans_in_10_days/design_system/colors.dart';
import 'package:vivans_in_10_days/design_system/text.dart';
import 'package:vivans_in_10_days/helpers/miscillenous.dart';
import 'package:vivans_in_10_days/router.dart';

void main() async {
  ThemeData customTheme() {
    return ThemeData(
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all<Color>(DesignColor.blue),
            checkColor: MaterialStateProperty.all(DesignColor.white)),
        // listTileTheme: ListTileThemeData(selectedColor: DesignColor.blue),
        scaffoldBackgroundColor: DesignColor.grey,
        appBarTheme:
            AppBarTheme(iconTheme: IconThemeData(color: DesignColor.black)),
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

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ConnectivityCubit()..checkConnectivity(),
        lazy: false,
      ),
      BlocProvider(
        create: (context) => AuthCubit(),
        lazy: false,
      )
    ],
    child: MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: customTheme(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool _isDialogDisplayed = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state == ConnectivityState.disconnected) {
          _isDialogDisplayed = true;
        }
        if (state == ConnectivityState.connected &&
            _isDialogDisplayed == true) {
          _isDialogDisplayed = false;
        }
      },
      builder: (context, state) {
        if (state == ConnectivityState.init) {
          return const Scaffold(
              body: CircularProgressIndicator()); // These can be same
        }
        return _isDialogDisplayed
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
                ? Scaffold(body: Center(child: "Hello".textLargeBold()))
                : const Scaffold(
                    body: Center(
                        child:
                            CircularProgressIndicator())); /**alert: Add shimmer container here */
      },
    );
  }
}
