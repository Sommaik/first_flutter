import 'package:flutter/material.dart';
// import './tab_bar_demo.dart';
import 'package:first/tab_bar_demo.dart';
import 'package:first/login_screen.dart';

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
      initialRoute: '/login',
      routes: {
        '/': (context) => MyHome(),
        '/tabs': (context) => TabBarDemo(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.tab),
            onPressed: () {
              Navigator.pushNamed(context, '/tabs');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Hello This is counter"),
            Text("$counter"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          setState(() {
            counter++;
          });
          print(counter);
        },
      ),
    );
  }
}
