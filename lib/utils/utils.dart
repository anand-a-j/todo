import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/colors.dart';

showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onOk,
}) {
  Widget okButton = InkWell(
    onTap: () {
      onOk();
      Navigator.pop(context);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: Text(
          "Yes",
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  Widget cancelButton = InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade400, borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: Text(
          "Cancel",
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  AlertDialog alert = AlertDialog(
    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    title: Text(title),
    content: Text(content),
    actions: [okButton, cancelButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

DateTime? currentBackPressTime;

Future<bool> onWillPop() async {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2) &&
          now.difference(currentBackPressTime!) < const Duration(seconds: 5)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: 'Press back again to exit');
    return Future.value(false);
  }
  SystemNavigator.pop();
  return Future.value(true);
}


dateFormat(DateTime date) {
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}

Future<String> pickDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101));
  if (picked != null) {
    return dateFormat(picked);
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
