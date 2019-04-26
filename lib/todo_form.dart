import 'package:flutter/material.dart';
import 'package:first/models/todo_model.dart';

class TodoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoState();
  }
}

class TodoState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill in title";
                  }
                },
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    TodoProvider todoProvider = TodoProvider();
                    todoProvider.open("todo.db").then((value) {
                      Todo todo = Todo();
                      todo.title = _titleController.text;
                      todo.done = false;
                      todoProvider.insert(todo).then((id) {
                        Navigator.pop(context);
                      });
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Error. please fill in all field."),
                    ));
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
