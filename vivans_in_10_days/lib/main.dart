import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';
import 'package:vivans_in_10_days/helpers/miscillenous.dart';

void main() {
  runApp(BlocProvider(
    create: (BuildContext context) => ConnectivityCubit()..checkConnectivity(),
    lazy: false,
    child: MaterialApp(home: MyApp()),
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
                        "Please check your internet connection and try again",
                    buttonTitle: "Retry",
                    buttonType: ButtonType.filled,
                    iconData: Icons.wifi_off_rounded,
                    onTap: () {}),
              )
            : state == ConnectivityState.connected
                ? const MaterialApp(
                    home: Scaffold(body: Text("Hello there")),
                  )
                : const Scaffold(
                    body: Center(
                        child:
                            CircularProgressIndicator())); // These can be same
      },
    );
  }
}
