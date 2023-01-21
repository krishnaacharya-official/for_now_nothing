import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/cubit/auth/auth_cubit.dart';
import 'package:vivans_in_10_days/cubit/internet_cubit.dart';
import 'package:vivans_in_10_days/cubit/users/user_cubit.dart';

class Providers {
  static get getProviders => [
        BlocProvider(
          create: (context) => ConnectivityCubit()..checkConnectivity(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserCubit(),
          lazy: false,
        )
      ];
}
