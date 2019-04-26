import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'x@x.com',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) return 'Please fill in email address';
                },
                controller: emailController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Your password',
                ),
                obscureText: true,
                controller: passwordController,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    // pass
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth
                        .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    )
                        .then((FirebaseUser user) {
                      if (user.isEmailVerified) {
                        // goto main
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        Scaffold.of(_formKey.currentContext)
                            .showSnackBar(SnackBar(
                          content: Text("Please verified your email"),
                        ));
                      }
                    }).catchError((error) {
                      Scaffold.of(_formKey.currentContext)
                          .showSnackBar(SnackBar(
                        content: Text(error.toString()),
                      ));
                    });
                  } else {
                    Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
                      content: Text("Please fill in all field "),
                    ));
                  }
                },
              ),
              FlatButton(
                child: Text("Register new account"),
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
