import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/todo_provider.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screens/add_todo/add_update_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).fetchAllTodo();
    });
    return SafeArea(
      child: Scaffold(
        body: Consumer<TodoProvider>(builder: (context, todoProvider, child) {
          return todoProvider.isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 90,
                            width: 90,
                            // color: Colors.red,
                            child: CircularPercentIndicator(
                              radius: 30.0,
                              lineWidth: 8.0,
                              animation: true,
                              percent: todoProvider.calculateCompletedPercentage(
                                      todoProvider.totalCompletedTodos(),
                                      todoProvider
                                          .filterTodosByDate(
                                              todoProvider.selectedDate)
                                          .length) / 100,
                              center: Text(
                                "${todoProvider.calculateCompletedPercentage(
                                  todoProvider.totalCompletedTodos(), 
                                  todoProvider.filterTodosByDate(todoProvider.selectedDate).length)} %",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.purple,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            const Text(
                                "My Tasks",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0),
                              ),
                              Text(
                                "${todoProvider.totalCompletedTodos()} of ${todoProvider.filterTodosByDate(todoProvider.selectedDate).length} task completed",
                                style:const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: DatePicker(
                        DateTime.now(),
                        initialSelectedDate: DateTime.now(),
                        selectionColor: const Color.fromARGB(255, 127, 12, 184),
                        selectedTextColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        onDateChange: (date) {
                          todoProvider.setSelectedDate(date);
                        },
                      ),
                    ),
                    todoProvider
                            .filterTodosByDate(todoProvider.selectedDate)
                            .isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height / 2 -
                                            100),
                                const Text("No Todos Available..."),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: todoProvider
                                  .filterTodosByDate(todoProvider.selectedDate)
                                  .length,
                              itemBuilder: (context, index) {
                                var todo = todoProvider.filterTodosByDate(
                                    todoProvider.selectedDate)[index];
                                debugPrint("Todo ==> $todo");
                                return Slidable(
                                  // Specify a key if the Slidable is dismissible.
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        onPressed: (context) {
                                          print("Ontap ${todo.id}");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddUpdateTodoScreen(
                                                updateTodo: todo,
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor: Colors.purple,
                                        foregroundColor: Colors.white,
                                        icon: Icons.update,
                                        label: 'Update',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          todoProvider.deleteTodo(todo.id!);
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),

                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: todo.priority ==
                                                    Priority.high.label
                                                ? Priority.high.color
                                                : todo.priority ==
                                                        Priority.medium.label
                                                    ? Priority.medium.color
                                                    : Priority.low.color,
                                            borderRadius:
                                                const BorderRadius.only(
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
                                              style: TextStyle(
                                                  decoration:
                                                      todo.isCompleted == 1
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : null),
                                            ),
                                            subtitle: Text(
                                                "${todo.date} ● ${todo.time}"),
                                            onChanged: (value) {
                                              todo.isCompleted =
                                                  value == true ? 1 : 0;
                                              todoProvider.updateTodoCompleted(
                                                  todo.id!, todo.isCompleted);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddUpdateTodoScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
