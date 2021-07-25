abstract class NetworkState {}

class ConnectionInitial extends NetworkState {}

class ConnectionSuccess extends NetworkState {
  ConnectionSuccess({required this.tip});
  String tip;
}

class ConnectionFailure extends NetworkState {}
