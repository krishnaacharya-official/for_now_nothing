import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
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
  const MyApp({super.key});
  final bool _isDialogDisplayed = false;

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //       create: (context) => ConnectivityCubit(),
  //       child: MaterialApp(
  //           home: Scaffold(
  //               body: StreamBuilder<ConnectivityResult>(
  //                   stream: ConnectivityCubit().streamValue,
  //                   builder: (context, snapshot) {
  //                     // if (!snapshot.hasData) {
  //                     if (snapshot.data == ConnectivityResult.none ||
  //                         !snapshot.hasData) {
  //                       return MediaQuery(
  //                         data: MediaQuery.of(context)
  //                             .copyWith(textScaleFactor: 1.0),
  //                         child: Dialog(
  //                           child: Column(
  //                             children: <Widget>[
  //                               const Text('No internet connection'),
  //                               FilledButton(
  //                                 onPressed: () {
  //                                   BlocProvider.of<ConnectivityCubit>(context)
  //                                       .checkConnectivity();
  //                                 },
  //                                 child:
  //                                     const Text('Check Internet Connectivity'),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     } else if (snapshot.data == ConnectivityResult.mobile ||
  //                         snapshot.data == ConnectivityResult.ethernet ||
  //                         snapshot.data == ConnectivityResult.wifi) {
  //                       return Stack(
  //                         children: <Widget>[
  //                           // Other widgets
  //                           BlocConsumer<ConnectivityCubit, bool>(
  //                             listener: (context, state) {
  //                               if (!state) {
  //                                 _isDialogDisplayed = true;
  //                               } else {
  //                                 _isDialogDisplayed = false;
  //                                 ScaffoldMessenger.of(context).showSnackBar(
  //                                     const SnackBar(
  //                                         content: Text(
  //                                             'Welcome back, you are online now')));
  //                               }
  //                             },
  //                             builder: (context, state) {
  //                               return _isDialogDisplayed
  //                                   ? const ConnectivityDialog()
  //                                   : Container(child: const Text("Hello"));
  //                             },
  //                           ),
  //                           // Your main layout
  //                         ],
  //                       );
  //                       // Other routes
  //                     }
  //                     return const Center(child: CircularProgressIndicator());
  //                   }))));
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == ConnectivityResult.none) {
              return const AlertDialog(
                title: Text('No internet connection'),
                content: Text('Please check your internet connection.'),
              );
            }
            if (snapshot.hasData &&
                (snapshot.data == ConnectivityResult.mobile ||
                    snapshot.data == ConnectivityResult.wifi ||
                    snapshot.data == ConnectivityResult.ethernet)) {
              return const Text("Hello there");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
