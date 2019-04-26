import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill in email";
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill in password";
                  }
                },
              ),
              RaisedButton(
                child: Text("Register"),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((FirebaseUser user) {
                      user.sendEmailVerification().then((value) {
                        Navigator.pop(context);
                      });
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
