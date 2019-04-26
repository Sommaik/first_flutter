import 'package:flutter/material.dart';
// import './tab_bar_demo.dart';
import 'package:first/tab_bar_demo.dart';
import 'package:first/login_screen.dart';
import 'package:first/profile_screen.dart';
import 'my_home.dart';
import 'package:first/todo_form.dart';
import 'register_screen.dart';
import 'landing_screen.dart';
import 'map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingScreen(),
        '/tabs': (context) => TabBarDemo(),
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfileScreen(),
        '/newTask': (context) => TodoForm(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => MyHome(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}
