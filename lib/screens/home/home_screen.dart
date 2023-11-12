import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/screens/add_update_task/add_update_task_screen.dart';
import 'package:todo/screens/home/widget/all_task_header.dart';
import 'package:todo/screens/home/widget/confetti_stars.dart';
import 'package:todo/screens/home/widget/date_timeline.dart';
import 'package:todo/screens/home/widget/datewise_task_header.dart';
import 'package:todo/screens/home/widget/task_tile.dart';
import 'package:todo/utils/colors.dart';
import 'package:todo/utils/utils.dart';
import 'widget/empty_widget.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<TodoProvider>(builder: (context, todoProvider, child) {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   todoProvider.setStartAnimation(true);
        // });
        return DefaultTabController(
          length: 2,
          child: WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
              key: scaffoldKey,
              body: todoProvider.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        const ConfettiStars(),
                        TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.black,
                            splashBorderRadius: BorderRadius.circular(10),
                            indicatorPadding: const EdgeInsets.only(right: 10),
                            indicator: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            tabs: const [
                              Tab(
                                text: "DateWise",
                              ),
                              Tab(
                                text: "All",
                              )
                            ]),
                            
                        Expanded(
                          child: TabBarView(
                            children: [
                              Column(
                                children: [
                                  DateWiseTaskHeader(
                                      todoProvider: todoProvider),
                                  DateTimeline(todoProvider: todoProvider),
                                  todoProvider
                                          .filterTodosByDate(
                                              todoProvider.selectedDate)
                                          .isEmpty
                                      ? const EmptyWidget()
                                      : Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: todoProvider
                                                .filterTodosByDate(
                                                    todoProvider.selectedDate)
                                                .length,
                                            itemBuilder: (context, index) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                todoProvider
                                                    .setIsListAll(false);
                                              });
                                              var todo = todoProvider
                                                  .filterTodosByDate(
                                                      todoProvider
                                                          .selectedDate)[index];
                                              return TaskTile(
                                                  todoProvider: todoProvider,
                                                  todo: todo);
                                            },
                                          ),
                                        ),
                                ],
                              ),
                              todoProvider.todos == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : todoProvider.todos!.isEmpty
                                      ? const EmptyWidget()
                                      : Column(
                                          children: [
                                            AllTaskHeader(
                                                todoProvider: todoProvider),
                                            Expanded(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: todoProvider
                                                      .todos!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    todoProvider
                                                        .setIsListAll(true);
                                                    var todo = todoProvider
                                                        .todos![index];
                                                    return TaskTile(
                                                      todoProvider:
                                                          todoProvider,
                                                      todo: todo,
                                                    );
                                                  }),
                                            ),
                                          ],
                                        )
                            ],
                          ),
                        ),
                      ],
                    ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUpdateTaskScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: secondaryColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
