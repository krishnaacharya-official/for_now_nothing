import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;
  late Stream<ConnectivityResult> streamValue;
  ConnectivityCubit() : super(true) {
    streamValue = _connectivity.onConnectivityChanged;
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(false);
      } else {
        emit(true);
      }
    });
  }

  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      emit(false);
      return false;
    } else {
      emit(true);
      return true;
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
