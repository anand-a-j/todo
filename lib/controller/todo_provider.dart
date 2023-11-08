import 'package:flutter/material.dart';
import 'package:todo/database/todo_database.dart';
import 'package:todo/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  bool _isLoading = false;
  int? _todoId;
  List<TodoModel>? _todos = [];
  DateTime _selectedDate = DateTime.now();
  double _percentage = 0.0;

  bool get isLoading => _isLoading;
  int? get todoId => _todoId;
  List<TodoModel>? get todos => _todos;
  DateTime get selectedDate => _selectedDate;
  double get percentage => _percentage;

  void setSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void addTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    _todoId = await TodoDatebase.createTodo(todo);
    fetchAllTodo();

    _isLoading = false;
    notifyListeners();
  }

  void fetchAllTodo() async {
    _isLoading = true;
    notifyListeners();

    _todos = await TodoDatebase.fetchAllTodos();

    _isLoading = false;
    notifyListeners();
  }

  List<TodoModel> filterTodosByDate(DateTime selectedDate) {
    if (todos != null && todos!.isNotEmpty) {
      return todos!.where((todos) {
        DateTime? todoDate;
        List<String> dateParts = todos.date!.split('/');
        if (dateParts.length == 3) {
          int day = int.parse(dateParts[0]);
          int month = int.parse(dateParts[1]);
          int year = int.parse(dateParts[2]);

          todoDate = DateTime(year, month, day);
        } else {
          debugPrint("Invalid date format");
        }
        notifyListeners();
        return todoDate!.year == selectedDate.year &&
            todoDate.month == selectedDate.month &&
            todoDate.day == selectedDate.day;
      }).toList();
    } else {
      notifyListeners();
      return [];
    }
  }

  void updateTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    await TodoDatebase.updateTodo(todo);
    fetchAllTodo();

    _isLoading = false;
    notifyListeners();
  }

  void updateTodoCompleted(int id, int isCompleted) {
    TodoDatebase.updateTodoCompletion(id, isCompleted == 1 ? true : false);
    notifyListeners();
  }

  int totalCompletedTodos() {
    int count = 0;
    if (todos != null) {
      for (var todo in filterTodosByDate(selectedDate)) {
        if (todo.isCompleted == 1) {
          count++;
        }
      }
      return count;
    }
    return count;
  }

  int calculateCompletedPercentage(int completedCount, int totalCount) {
    if (totalCount == 0) {
      return 0; 
    }

    double percentage = (completedCount / totalCount) * 100;
    return percentage.toInt(); 
  }

  void deleteTodo(int id) async {
    await TodoDatebase.deleteTodo(id);
    fetchAllTodo();
    notifyListeners();
  }
}
