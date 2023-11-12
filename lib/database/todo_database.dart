import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo/model/todo_model.dart';

class TodoDatebase {
  /// Create Database-------------------------------------------------------------
  static Future<sql.Database> openDb() async {
    return sql.openDatabase('todo_db', version: 2,
        onCreate: ((db, version) async {
      await createTable(db);
    }));
  }

  /// Create Table--------------------------------------------------------------
  static Future<void> createTable(sql.Database db) async {
    await db.execute("""CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        task TEXT,
        date TEXT,
        time TEXT,
        color TEXT,
        priority TEXT,
        isCompleted INTEGER,
        description TEXT
      )""");
  }

  /// Create Todo---------------------------------------------------------------
  static Future<int> createTodo(TodoModel todo) async {
    final db = await TodoDatebase.openDb();
    final id = db.insert('todo', {
      'task': todo.task,
      'date': todo.date,
      'time': todo.time,
      'color': todo.color.toString(),
      'priority': todo.priority.toString(),
      'isCompleted': todo.isCompleted,
      'description': todo.description
    });
    return id;
  }

  /// Fetch all todos-----------------------------------------------------------
  static Future<List<TodoModel>> fetchAllTodos() async {
    final db = await TodoDatebase.openDb();
    final List<Map<String, dynamic>> results =
        await db.rawQuery("SELECT * FROM todo");
    List<TodoModel> data = [];
    for (var result in results) {
      data.add(TodoModel.fromMap(result));
    }
    return data;
  }

  /// Update todo----------------------------------------------------------------
  static Future<void> updateTodo(TodoModel todo) async {
    final db = await TodoDatebase.openDb();
       await db.update(
          'todo',
          {
            'task': todo.task,
            'date': todo.date,
            'time': todo.time,
            'color': todo.color.toString(),
            'priority': todo.priority.toString(),
            'isCompleted': todo.isCompleted,
            'description': todo.description
            
          },
          where: 'id = ?',
          whereArgs: [todo.id]);
  }

  /// updateTodoCompletion------------------------------------------------------
  static Future<void> updateTodoCompletion(int id, bool isCompleted) async {
    final db = await TodoDatebase.openDb();
    await db.update('todo', {'isCompleted': isCompleted ? 1 : 0},
        where: 'id=?', whereArgs: [id]);
  }

  /// Delete todo---------------------------------------------------------------
  static Future<void> deleteTodo(int id) async {
    final db = await TodoDatebase.openDb();
    await db.delete('todo', where: 'id=?', whereArgs: [id]);
  }

  /// Delete all todos----------------------------------------------------------
  static Future<void> deleteAllTodos() async {
    final db = await TodoDatebase.openDb();
    await db.delete('todo');
  }
}
