import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color.fromARGB(255, 127, 12, 184),
                selectedTextColor: const Color.fromARGB(255, 255, 255, 255),
                onDateChange: (date) {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            value: true,
                            title: const Text("Title"),
                            subtitle: const Text("12/09/2023 ● 12:00 PM"),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
