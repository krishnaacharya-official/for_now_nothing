  // body: BlocConsumer<ConnectivityCubit, bool>(
  //             listener: (context, state) {
  //               if (state == false) {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) {
  //                     return Dialog(
  //                       child: Column(
  //                         children: <Widget>[
  //                           const Text('No internet connection'),
  //                           FilledButton(
  //                             onPressed: () {
  //                               BlocProvider.of<ConnectivityCubit>(context)
  //                                   .checkConnectivity();
  //                             },
  //                             child: const Text('Check Internet Connectivity'),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 );
  //               }
  //             },
  //             builder: (context, state) {
  //               return Container();
  //             },
  //           ),