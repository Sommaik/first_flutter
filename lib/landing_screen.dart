import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_home.dart';
import 'login_screen.dart';
import 'package:first/blocs/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingScreen extends StatelessWidget {
  final CounterBloc _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            bloc: _bloc,
            child: MyHome(),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
