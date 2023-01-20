import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityState { connected, disconnected, init }

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;
  late Stream<ConnectivityResult> streamValue;
  ConnectivityCubit() : super(ConnectivityState.init) {
    streamValue = _connectivity.onConnectivityChanged;
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(ConnectivityState.disconnected);
      } else {
        emit(ConnectivityState.connected);
      }
    });
  }

  checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      emit(ConnectivityState.disconnected);
    } else {
      emit(ConnectivityState.connected);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
