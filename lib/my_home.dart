import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File;

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePage();
  }
}

class MyHomePage extends State {
  int counter = 0;
  @override
  void initState() {
    super.initState();
    readCounter().then((int value) {
      setState(() {
        counter = value;
      });
    });
  }

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
          writeCounter(counter);
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
}
