import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';

class ConnectivityDialog extends StatelessWidget {
  const ConnectivityDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, bool>(
      builder: (context, state) {
        if (!state) {
          return AlertDialog(
            title: const Text('No internet connection'),
            content: const Text('Please check your internet connection.'),
            actions: <Widget>[
              FilledButton(
                child: const Text('Check again'),
                onPressed: () => BlocProvider.of<ConnectivityCubit>(context)
                    .checkConnectivity(),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
