import 'package:flutter/material.dart';
import 'package:todo/screens/add_todo/widget/custom_textfield.dart';

class AddUpdateTodoScreen extends StatelessWidget {
  final bool isUpdate;
  const AddUpdateTodoScreen({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUpdate ? "Update Todo" : "Add Todo",
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
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: timeController,
              hintText: "Time",
              enableSuffixIcon: true,
              suffixIcon: Icons.timer,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: priorityController,
              hintText: "Priority",
              enableSuffixIcon: true,
              suffixIcon: Icons.arrow_downward,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {

              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text("Save",
                    style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
