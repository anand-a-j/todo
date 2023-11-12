import 'package:flutter/material.dart';

enum Priority {
  low('Low', Color.fromARGB(255, 250, 254, 43)),
  medium('Medium', Color(0xff867dff)),
  high('High', Color(0xfff47575));

  const Priority(this.label, this.color);
  final String label;
  final Color color;
}

class TodoModel {
  final int? id;
  String task;
  String? description;
  String? date;
  String? time;
  String? color;
  String priority = Priority.low.label;
  int isCompleted = 0;

  TodoModel(
      {this.id,
      required this.task,
      required this.date,
      required this.time,
      required this.color,
      required this.priority,
      required this.isCompleted,
      required this.description
      });

  factory TodoModel.fromMap(Map<String, dynamic> json) {
    return TodoModel(
        id: json['id'],
        task: json['task'],
        date: json['date'],
        time: json['time'],
        priority: json['priority'],
        isCompleted: json['isCompleted'],
        description: json['description'],
        color: json['color']
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'date': date,
      'time': time,
      'color': color,
      'priority': priority,
      'isCompleted': isCompleted,
      'description': description ?? '0xffffd8f4'
    };
  }
}
