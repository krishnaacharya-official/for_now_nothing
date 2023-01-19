import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';
import 'package:vivans_in_10_days/helpers/connectivity_dialog.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   bool _isDialogDisplayed = false;

//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => ConnectivityCubit(),
//         child: MaterialApp(
//             home: Scaffold(
//                 body: Stack(
//           children: <Widget>[
//             // Other widgets
//             BlocConsumer<ConnectivityCubit, bool>(
//               listener: (context, state) {
//                 if (!state && !_isDialogDisplayed) {
//                   _isDialogDisplayed = true;
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Dialog(
//                         child: Column(
//                           children: <Widget>[
//                             const Text('No internet connection'),
//                             FilledButton(
//                               onPressed: () {
//                                 BlocProvider.of<ConnectivityCubit>(context)
//                                     .checkConnectivity();
//                               },
//                               child: const Text('Check Internet Connectivity'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state && _isDialogDisplayed) {
//                   _isDialogDisplayed = false;
//                   Navigator.of(context).pop();
//                 }
//               },
//               builder: (context, state) {
//                 return Container();
//               },
//             ),
//           ],
//         ))));
//   }
// }
//           // Other routes

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool _isDialogDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ConnectivityCubit(),
        child: MaterialApp(
            home: Scaffold(
                body: StreamBuilder<ConnectivityResult>(
                    stream: ConnectivityCubit().streamValue,
                    builder: (context, snapshot) {
                      // if (!snapshot.hasData) {
                      if (snapshot.data == ConnectivityResult.none ||
                          !snapshot.hasData) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                          child: Dialog(
                            child: Column(
                              children: <Widget>[
                                const Text('No internet connection'),
                                FilledButton(
                                  onPressed: () {
                                    BlocProvider.of<ConnectivityCubit>(context)
                                        .checkConnectivity();
                                  },
                                  child:
                                      const Text('Check Internet Connectivity'),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.data == ConnectivityResult.mobile ||
                          snapshot.data == ConnectivityResult.ethernet ||
                          snapshot.data == ConnectivityResult.wifi) {
                        return Stack(
                          children: <Widget>[
                            // Other widgets
                            BlocConsumer<ConnectivityCubit, bool>(
                              listener: (context, state) {
                                if (!state) {
                                  _isDialogDisplayed = true;
                                } else {
                                  _isDialogDisplayed = false;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Welcome back, you are online now')));
                                }
                              },
                              builder: (context, state) {
                                return _isDialogDisplayed
                                    ? const ConnectivityDialog()
                                    : Container(child: const Text("Hello"));
                              },
                            ),
                            // Your main layout
                          ],
                        );
                        // Other routes
                      }
                      return const Center(child: CircularProgressIndicator());
                    }))));
  }
}
