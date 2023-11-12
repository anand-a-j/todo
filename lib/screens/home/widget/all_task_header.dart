import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/theme_provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/utils/utils.dart';

class AllTaskHeader extends StatelessWidget {
  final TodoProvider todoProvider;
  const AllTaskHeader({super.key, required this.todoProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: 90,
            width: 90,
            child: CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 8.0,
              animation: true,
              percent: todoProvider.calculateCompletedPercentage(
                      todoProvider.totalCompletedTodos(true),
                      todoProvider.todos!.length) /
                  100,
              center: Text(
                "${todoProvider.calculateCompletedPercentage(todoProvider.totalCompletedTodos(true), todoProvider.todos!.length)} %",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Tasks",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "${todoProvider.totalCompletedTodos(true)} of ${todoProvider.todos!.length} task completed",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Spacer(),
          Consumer<ThemeProvider>(builder: (context, theme, child) {
            return IconButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  theme.toggleTheme();
                });
              },
              icon: theme.darkTheme == true
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode, color: Colors.amber),
            );
          }),
      
          IconButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showAlertDialog(
                    context: context,
                    title: "Confirm Delete",
                    content: "Do you wanna delete all the tasks?",
                    onOk: () {
                      todoProvider.deleteAllTodos();
                    });
              });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
