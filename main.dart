import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/network_bloc.dart';
import 'bloc/network_event.dart';
import 'bloc/network_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => NetworkBloc()..add(CheckConnection()),
          child: HomeScreen(),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocProvider.value(
      value: BlocProvider.of<NetworkBloc>(context),
      child: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is ConnectionFailure) return Text("No Internet Connection");
          if (state is ConnectionSuccess)
            return Text("You're Connected to Internet ${state.tip}");
          else
            return Text(state.toString());
        },
      ),
    ));
  }
}
