import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDone = 'done';

class Todo {
  int id;
  String title;
  bool done;

  Todo();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done ? 1 : 0,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }
}

class TodoProvider {
  Database db;

  Future<bool> open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableTodo (
        $columnId integer primary key autoincrement,
        $columnTitle text not null,
        $columnDone integer not null
      )
      ''');
    });
    return true;
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(
      tableTodo,
      columns: [columnId, columnTitle, columnDone],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Todo.fromMap(maps[0]);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    return await db.delete(
      tableTodo,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Todo todo) async {
    return await db.update(
      tableTodo,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id],
    );
  }

  Future close() {
    return db.close();
  }

  Future<List<Todo>> listByStatus(int done) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnTitle, columnDone],
        where: '$columnDone = ?',
        whereArgs: [done]);
    return maps.map((data) {
      return Todo.fromMap(data);
    }).toList();
  }

  Future<int> deletCompleted() async {
    return await db.delete(
      tableTodo,
      where: '$columnDone = ?',
      whereArgs: [1],
    );
  }
}
