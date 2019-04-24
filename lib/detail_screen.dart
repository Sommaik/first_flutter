import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;

  DetailScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
