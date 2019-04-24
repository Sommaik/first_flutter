import 'package:flutter/material.dart';
import 'package:first/detail_screen.dart';

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
            Text("Car"),
            Icon(Icons.accessible_forward),
            RaisedButton(
              child: Text("Boat"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          title: 'Test from tab',
                        ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
