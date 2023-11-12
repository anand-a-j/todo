import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/controllers/todo_provider.dart';

class DateTimeline extends StatelessWidget {
  final TodoProvider todoProvider;
  const DateTimeline({super.key, required this.todoProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(5),
      child: DatePicker(
        DateTime.now().subtract(const Duration(days: 2)),
        initialSelectedDate: DateTime.now(),
        selectionColor: Theme.of(context).primaryColor,
        selectedTextColor: Theme.of(context).scaffoldBackgroundColor,
        // dayTextStyle: Theme.of(context).textTheme.bodyLarge!,
        // monthTextStyle: Theme.of(context).textTheme.bodyLarge!,
        // dateTextStyle: Theme.of(context).textTheme.displayMedium!,
        onDateChange: (date) {
          todoProvider.setSelectedDate(date);
        },
      ),
    );
  }
}
