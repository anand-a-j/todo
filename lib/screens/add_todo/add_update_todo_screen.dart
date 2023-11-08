import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/todo_provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screens/add_todo/widget/custom_textfield.dart';

class AddUpdateTodoScreen extends StatelessWidget {
  final TodoModel? updateTodo;
  const AddUpdateTodoScreen({super.key, this.updateTodo});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();

    final List<DropdownMenuEntry<String>> priorityEntires =
        <DropdownMenuEntry<String>>[];

    for (final priorityValue in Priority.values) {
      priorityEntires.add(
        DropdownMenuEntry(
          value: priorityValue.label,
          label: priorityValue.label,
        ),
      );
    }
    if (updateTodo != null) {
      titleController.text = updateTodo!.task;
      descriptionController.text = updateTodo?.description ?? '';
      dateController.text = updateTodo!.date!;
      timeController.text = updateTodo!.time!;
      priorityController.text = updateTodo!.priority;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text(
              updateTodo != null ? "Update Todo" : "Add Todo",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomTextField(controller: titleController, hintText: "Title"),
            const SizedBox(height: 10),
            CustomTextField(
                controller: descriptionController, hintText: "Description"),
            const SizedBox(height: 10),
            CustomTextField(
              controller: dateController,
              hintText: "Date",
              enableSuffixIcon: true,
              suffixIcon: Icons.calendar_month,
              readOnly: true,
              onPressed: () async {
                dateController.text = await pickDate(context);
              },
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: timeController,
              hintText: "Time",
              enableSuffixIcon: true,
              readOnly: true,
              suffixIcon: Icons.timer,
              onPressed: () async {
                timeController.text = await timePicker(context);
              },
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                CustomTextField(
                  readOnly: true,
                  controller: priorityController,
                  hintText: "Priority",
                ),
                Positioned(
                  right: 0,
                  child: PopupMenuButton<Priority>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (v) {
                      priorityController.text = v.label;
                    },
                    itemBuilder: (BuildContext context) {
                      return Priority.values.map((Priority choice) {
                        return PopupMenuItem<Priority>(
                          value: choice,
                          child: Text(choice.label),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Consumer<TodoProvider>(builder: (context, todoProvider, child) {
              return InkWell(
                onTap: () {
                  if (updateTodo?.id == null) {
                    if (timeController.text.isEmpty) {
                    } else if (dateController.text.isEmpty) {
                    } else if (timeController.text.isEmpty) {
                    } else if (priorityController.text.isEmpty) {
                    } else {
                      TodoModel todo = TodoModel(
                          task: titleController.text.trim(),
                          date: dateController.text,
                          time: timeController.text,
                          priority: priorityController.text,
                          description: descriptionController.text,
                          isCompleted: 0);

                      todoProvider.addTodo(todo);
                      if (todoProvider.todoId != null) {
                        Navigator.pop(context);
                        debugPrint(
                            "<================Todo added successfully=============>");
                      }
                    }
                  } else {
                    if (timeController.text.isEmpty) {
                    } else if (dateController.text.isEmpty) {
                    } else if (timeController.text.isEmpty) {
                    } else if (priorityController.text.isEmpty) {
                    } else {
                      updateTodo!.task = titleController.text;
                      updateTodo!.description = descriptionController.text;
                      updateTodo!.date = dateController.text;
                      updateTodo!.time = timeController.text;
                      updateTodo!.priority = priorityController.text;
                      todoProvider.updateTodo(updateTodo!);

                      Navigator.pop(context);
                      debugPrint(
                          "<==============Todo updated successfully=============>");
                    }
                  }

                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: todoProvider.isLoading == true
                        ? const Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Loading...",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        : const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<String> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      return formattedDate;
    } else {
      return '';
    }
  }

  Future<String> timePicker(BuildContext context) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    return timeOfDayConvert(pickedTime!);
  }

  String timeOfDayConvert(TimeOfDay time) {
    final TimeOfDay timeOfDay = TimeOfDay(hour: time.hour, minute: time.minute);

    DateTime now = DateTime.now();

    DateTime combinedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    final DateFormat formatter = DateFormat('hh:mm a');
    String formattedTime = formatter.format(combinedDateTime);

    return formattedTime;
  }
}
