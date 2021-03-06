import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'blocs/counter_bloc.dart';
import 'blocs/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State {
  int counter = 0;
  SharedPreferences _perf;

  @override
  void initState() {
    super.initState();
    // readCounter().then((int value) {
    //   setState(() {
    //     counter = value;
    //   });
    // });
    SharedPreferences.getInstance().then((perf) {
      setState(() {
        _perf = perf;
        counter = perf.getInt("counter") ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CounterBloc _bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("First App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.tab),
            onPressed: () {
              Navigator.pushNamed(context, '/tabs');
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.pushNamed(context, '/map');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Hello This is counter"),
            buildCounter(_bloc),
            buildUserInfo(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          // setState(() {
          //   counter++;
          // });
          // // writeCounter(counter);
          // _perf.setInt("counter", counter);
          _bloc.dispatch(CounterEvent.increment);
        },
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    return file.writeAsString('$counter');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Widget buildUserInfo() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return Text(user.email);
        } else {
          return Text("Loading...");
        }
      },
    );
  }

  Widget buildCounter(CounterBloc _bloc) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, int value) {
        return Text("$value");
      },
    );
  }
}
