import 'package:flutter/material.dart';
import 'post_list_screen.dart';
import 'todo_screen.dart';
import 'book_list_screen.dart';

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tab bar demo"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_boat)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PostListScreen(),
            TodoScreen(),
            BookListScreen(),
          ],
        ),
      ),
    );
  }
}
