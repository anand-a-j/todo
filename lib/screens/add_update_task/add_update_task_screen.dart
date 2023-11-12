import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screens/add_update_task/widget/custom_textfield.dart';
import 'package:todo/utils/colors.dart';
import 'package:todo/utils/utils.dart';

class AddUpdateTaskScreen extends StatelessWidget {
  final TodoModel? updateTodo;
  const AddUpdateTaskScreen({super.key, this.updateTodo});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();

    final List<DropdownMenuEntry<String>> priorityEntires =
        <DropdownMenuEntry<String>>[];

    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<TodoProvider>(builder: (context, todoProvider, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(updateTodo != null ? "Update Task" : "Add Task",
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 20),
                CustomTextField(controller: titleController, hintText: "Task"),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: descriptionController,
                    hintText: "Description",
                    maxLines: 4),
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
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: todoTileColors.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          todoProvider.setSelectedColor(todoTileColors[index]);
                        },
                        child: todoProvider.selectedColor !=
                                todoTileColors[index]
                            ? CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(todoTileColors[index]),
                                child: todoProvider.selectedColor ==
                                        todoTileColors[index]
                                    ? const Icon(Icons.done,
                                        color: secondaryColor)
                                    : null,
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(todoTileColors[index]),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: secondaryColor,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          Color(todoTileColors[index]),
                                      child: todoProvider.selectedColor ==
                                              todoTileColors[index]
                                          ? const Icon(Icons.done,
                                              color: secondaryColor)
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 15),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (updateTodo?.id == null) {
                        if (titleController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Enter the task!!!");
                        } else {
                          if (descriptionController.text.isEmpty) {
                            descriptionController.text = '';
                          }

                          if (dateController.text.isEmpty) {
                            dateController.text = dateFormat(DateTime.now());
                          }

                          if (timeController.text.isEmpty) {
                            timeController.text = timeOfDayConvert(TimeOfDay(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute));
                          }

                          if (priorityController.text.isEmpty) {
                            priorityController.text = Priority.medium.label;
                          }

                          if (todoProvider.selectedColor == null) {
                            todoProvider.setSelectedColor(todoTileColors[0]);
                          }

                          TodoModel todo = TodoModel(
                              task: titleController.text.trim(),
                              date: dateController.text,
                              time: timeController.text,
                              priority: priorityController.text,
                              description: descriptionController.text,
                              isCompleted: 0,
                              color: todoProvider.selectedColor.toString());

                          todoProvider.addTodo(todo);
                          Navigator.pop(context);
                        }
                      } else {
                        if (timeController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Enter the task!!!");
                        } else if (dateController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Select the date");
                        } else if (timeController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Select the time");
                        } else if (priorityController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Select the task priority");
                        } else {
                          updateTodo!.task = titleController.text;
                          updateTodo!.description = descriptionController.text;
                          updateTodo!.date = dateController.text;
                          updateTodo!.time = timeController.text;
                          updateTodo!.priority = priorityController.text;
                          updateTodo!.color =
                              todoProvider.selectedColor.toString();
                          todoProvider.updateTodo(updateTodo!);

                          Navigator.pop(context);
                        }
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: todoProvider.isLoading == true
                          ? const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: secondaryColor,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Loading...",
                                    style: TextStyle(color: secondaryColor),
                                  )
                                ],
                              ),
                            )
                          : const Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
