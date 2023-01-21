import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivans_in_10_days/helpers/custom_theme.dart';
import 'package:vivans_in_10_days/helpers/providers.dart';
import 'package:vivans_in_10_days/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: Providers.getProviders,
    child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.customTheme()),
  ));
}
