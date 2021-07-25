import 'package:flutter_application_1/bloc/network_state.dart';

abstract class NetworkEvent {}

class ListenConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  NetworkState connection;
  ConnectionChanged(this.connection);
}

class CheckConnection extends NetworkEvent {}
