import 'package:sqflite/sqflite.dart' as sql;

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
    await db.execute(
      """CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        task TEXT,
        date TEXT,
        time TEXT,
        priority TEXT,
        isCompleted INTEGER,
        description TEXT
      )"""
    );
  }
}
