import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/bloc/network_event.dart';
import 'package:flutter_application_1/bloc/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(ConnectionInitial());

  StreamSubscription? _subscription;
  var isDeviceConnected = false;

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is CheckConnection) {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (isDeviceConnected) {
        yield ConnectionSuccess(tip: "net");
      } else {
        yield ConnectionFailure();
      }
      add(ListenConnection());
    }
    if (event is ListenConnection) {
      _subscription =
          Connectivity().onConnectivityChanged.listen((status) async {
        print(status);
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected) {
          add(ConnectionChanged(ConnectionSuccess(tip: status.toString())));
        } else {
          add(ConnectionChanged(ConnectionFailure()));
        }
      });
    }
    if (event is ConnectionChanged) {
      yield event.connection;
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
