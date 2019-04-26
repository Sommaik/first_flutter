import 'package:flutter/material.dart';
import 'package:first/models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoScreenState();
  }
}

class TodoScreenState extends State<TodoScreen> {
  int tabIndex = 0;
  TodoProvider _provider = TodoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _provider.open("todo.db"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return buildListData();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: tabIndex == 0
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, "/newTask");
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.delete),
              onPressed: () {
                _provider.deleteCompleted();
                setState(() {});
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int tab) {
          setState(() {
            tabIndex = tab;
          });
        },
        currentIndex: tabIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Task"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            title: Text("Completed"),
          ),
        ],
      ),
    );
  }

  Widget buildListData() {
    return FutureBuilder(
      future: _provider.listByStatus(tabIndex),
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshort) {
        if (snapshort.hasData) {
          List<Todo> data = snapshort.data;
          return data.length > 0
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(data[index].title),
                      trailing: Checkbox(
                        value: data[index].done,
                        onChanged: (bool value) {
                          Todo todo = data[index];
                          todo.done = value;
                          _provider.update(todo);
                          setState(() {});
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("No data found."),
                );
        }
      },
    );
  }
}
