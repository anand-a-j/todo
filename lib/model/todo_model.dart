enum Priority { high, medium, low }

class TodoModel {
  final int id;
  String task;
  String? description;
  DateTime? date;
  DateTime? time;
  Priority priority = Priority.low;
  bool isCompleted = false;

  TodoModel(
      {required this.id,
      required this.task,
      required this.date,
      required this.time,
      required this.priority,
      required this.isCompleted,
      required this.description});

  factory TodoModel.fromMap(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'],
        task: json['task'],
        date: json['date'],
        time: json['time'],
        priority: json['priority'],
        isCompleted: json['isCompleted'],
        description: json['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'date': date ?? DateTime.now(),
      'time': time ?? DateTime.now(),
      'priority': priority,
      'isCompleted': isCompleted,
      'description': description ?? ''
    };
  }
}
