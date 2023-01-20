import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';

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
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('No Internet'),
              content: Text('Please check your internet connection.'),
            ),
          );
        }
        if (state == ConnectivityState.connected &&
            _isDialogDisplayed == true) {
          Navigator.of(context).pop();
          _isDialogDisplayed = false;
        }
      },
      builder: (context, state) {
        if (state == ConnectivityState.init) {
          return const Scaffold(
              body: CircularProgressIndicator()); // These can be same
        }
        return state == ConnectivityState.connected
            ? const MaterialApp(
                home: Scaffold(body: Text("Hello there")),
              )
            : const Scaffold(
                body: Center(
                    child: CircularProgressIndicator())); // These can be same
      },
    );
  }
}
