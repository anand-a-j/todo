import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/database/todo_database.dart';
import 'package:todo/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  bool _isLoading = false;
  int? _todoId;
  List<TodoModel>? _todos = [];
  DateTime _selectedDate = DateTime.now();
  final double _percentage = 0.0;
  int? _selectedColor;
  bool _isListAll = false;
  ConfettiController _starController =
      ConfettiController(duration: const Duration(seconds: 3));
  // bool _startAnimation = false;

  bool get isLoading => _isLoading;
  int? get todoId => _todoId;
  List<TodoModel>? get todos => _todos;
  DateTime get selectedDate => _selectedDate;
  double get percentage => _percentage;
  int? get selectedColor => _selectedColor;
  bool get isListAll => _isListAll;
  ConfettiController get starController => _starController;
  // bool get startAnimation => _startAnimation;

  // void setStartAnimation(bool value) {
  //   _startAnimation = value;
  //   notifyListeners();
  // }

  void setSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void setSelectedColor(int newColor) {
    _selectedColor = newColor;
    notifyListeners();
  }

  void setIsListAll(bool value) {
    _isListAll = value;
  }

  void addTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    _todoId = await TodoDatebase.createTodo(todo);
    fetchAllTodo();
    Fluttertoast.showToast(msg: 'Task added successfully');

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
        }
        return todoDate!.year == selectedDate.year &&
            todoDate.month == selectedDate.month &&
            todoDate.day == selectedDate.day;
      }).toList();
    } else {
      return [];
    }
  }

  void updateTodo(TodoModel todo) async {
    _isLoading = true;
    notifyListeners();

    await TodoDatebase.updateTodo(todo);
    fetchAllTodo();
    Fluttertoast.showToast(msg: 'Todo updated succesfully');

    _isLoading = false;
    notifyListeners();
  }

  updateTodoCompleted(int id, int isCompleted) {
    TodoDatebase.updateTodoCompletion(id, isCompleted == 1 ? true : false);
    notifyListeners();
    // if (isCompleted == 1) {
    //   int index = todos!.indexWhere((todo) => todo.id == id);

    //   if (index != -1) {
    //     TodoModel completedTask = todos!.removeAt(index);
    //     todos!.add(completedTask);
    //   }
    // }
  }

  int totalCompletedTodos(bool isAll) {
    int count = 0;
    if (todos != null) {
      if (isAll == false) {
        for (var todo in filterTodosByDate(selectedDate)) {
          if (todo.isCompleted == 1) {
            count++;
          }
        }
        return count;
      } else {
        for (var todo in todos!) {
          if (todo.isCompleted == 1) {
            count++;
          }
        }
        return count;
      }
    }
    return count;
  }

  int calculateCompletedPercentage(int completedCount, int totalCount) {
    if (totalCount == 0) {
      return 0;
    }

    double percentage = (completedCount / totalCount) * 100;
    if (percentage.toInt() == 100) {
      _starController.play();
    } else {
      _starController.stop();
    }
    return percentage.toInt();
  }

  void deleteTodo(int id) async {
    await TodoDatebase.deleteTodo(id);
    Fluttertoast.showToast(msg: 'Task deleted successfully');
    fetchAllTodo();
    notifyListeners();
  }

  void deleteAllTodos() async {
    await TodoDatebase.deleteAllTodos();
    Fluttertoast.showToast(msg: 'All tasks deleted successfully');
    fetchAllTodo();
    notifyListeners();
  }
}
