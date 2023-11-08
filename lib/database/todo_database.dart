import 'package:sqflite/sqflite.dart' as sql;
import 'package:todo/model/todo_model.dart';

class TodoDatebase {
  /// Create Database-------------------------------------------------------------
  static Future<sql.Database> openDb() async {
    return sql.openDatabase('todo_db', version: 1,
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
      'priority': todo.priority.toString(),
      'isCompleted': todo.isCompleted ? 1 : 0,
      'description': todo.description
    });
    return id;
  }

  /// Fetch all todos-----------------------------------------------------------
  static Future<List<TodoModel>> fetchAllTodos() async {
    final db = await TodoDatebase.openDb();
    final List<TodoModel> data = await db.rawQuery("SELECT * FROM todo") as List<TodoModel>;
    return data;
  }
  

}
