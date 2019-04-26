import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_home.dart';
import 'login_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          return MyHome();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
