import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/screens/add_update_task/add_update_task_screen.dart';
import 'package:todo/screens/home/home_screen.dart';
import 'package:todo/utils/colors.dart';
import 'package:todo/utils/utils.dart';

class TaskTile extends StatelessWidget {
  final TodoProvider todoProvider;
  final TodoModel todo;
  const TaskTile({super.key, required this.todoProvider, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showTaskDetailsBottomSheet(context);
            },
            backgroundColor: Colors.green,
            foregroundColor: secondaryColor,
            icon: Icons.info_outline,
          ),
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUpdateTaskScreen(
                    updateTodo: todo,
                  ),
                ),
              );
            },
            backgroundColor: Colors.deepPurple,
            foregroundColor: secondaryColor,
            icon: Icons.update,
          ),
          SlidableAction(
            onPressed: (context) {
              showAlertDialog(
                context: scaffoldKey.currentContext!,
                title: "Confirm Delete",
                content: "Do you wanna delete this task?",
                onOk: () {
                  todoProvider.deleteTodo(todo.id!);
                },
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: secondaryColor,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        // curve: Curves.easeInOut,
        // transform: Matrix4.translationValues(todoProvider.startAnimation ? 0 : 50, 0, 0),
        // duration: const Duration(milliseconds: 800),
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(int.parse(todo.color!)),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 75,
              decoration: BoxDecoration(
                color: todo.priority == Priority.high.label
                    ? Priority.high.color
                    : todo.priority == Priority.medium.label
                        ? Priority.medium.color
                        : Priority.low.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: todo.isCompleted == 1,
                title: Text(
                  todo.task,
                  style: todo.isCompleted == 1
                      ? const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black12,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.lineThrough)
                      : Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  "${todo.date} ● ${todo.time}",
                  style: todo.isCompleted == 1
                      ? const TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black12,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.lineThrough)
                      : Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                onChanged: (value) {
                  todo.isCompleted = value == true ? 1 : 0;
                  todoProvider.updateTodoCompleted(todo.id!, todo.isCompleted);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showTaskDetailsBottomSheet(BuildContext context) {
    return showModalBottomSheet(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
               ),
                context: context,
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.task,
                              style:
                                  Theme.of(context).textTheme.displayMedium,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${todo.date} ● ${todo.time}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 10),
                           ListView(
                            shrinkWrap: true,
                              children: [
                                Text(
                                  todo.description ?? '',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
  }
}
