import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  Widget dayWidget(String dayNumber, String dayName,
      {bool isCurrentDay = false}) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCurrentDay
              ? const Color.fromRGBO(1, 65, 189, 1)
              : Colors.blue.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName.substring(0, 3),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: isCurrentDay ? Colors.white : null,
              ),
            ),
            Text(
              dayNumber,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isCurrentDay ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getCurrentWeekDashboard() {
    DateTime currentDate = DateTime.now();
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));

    List<Widget> listOfDays = [];

    for (int i = 0; i < 7; i++) {
      DateTime day = firstDayOfWeek.add(Duration(days: i));
      String formattedDayNumber = DateFormat('dd').format(day);
      String formattedDayName = DateFormat('EEEE').format(day);
      listOfDays.add(
        dayWidget(
          formattedDayNumber,
          formattedDayName,
          isCurrentDay: day.day == currentDate.day,
        ),
      );
    }

    return listOfDays;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: getCurrentWeekDashboard(),
      ),
    );
  }
}
