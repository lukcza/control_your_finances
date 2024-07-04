import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FrequencyView extends StatefulWidget {
  FrequencyView({Key? key}) : super(key: key);

  @override
  State<FrequencyView> createState() => _FrequencyViewState();
}

class _FrequencyViewState extends State<FrequencyView> {
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
  );

  bool? isAutoFrequencyChecked = false;
  bool? isWeeklyFrequencyChecked = false;
  bool? isMonthlyFrequencyChecked = false;
  bool? isYearlyFrequencyChecked = false;
  String _selectedFrequency = "Daily";
  void dropdownCallback(String? selectedFrequency) {
    if (selectedFrequency is String) {
      setState(() {
        _selectedFrequency = selectedFrequency;
      });
    }
  }

  //table
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: isAutoFrequencyChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isAutoFrequencyChecked = value;
                      print("$isAutoFrequencyChecked");
                    });
                  },
                ),
                const Text("Auto frequency"),
              ],
            ),
            if (isAutoFrequencyChecked != false) ...[
              Divider(
                height: 1,
              ),
              DropdownButton(
                value: _selectedFrequency,
                items: const [
                  DropdownMenuItem(child: Text("Daily"), value: "Daily"),
                  DropdownMenuItem(child: Text("Weekly"), value: "Weekly"),
                  DropdownMenuItem(child: Text("Monthly"), value: "Monthly"),
                  DropdownMenuItem(child: Text("Yearly"), value: "Yearly"),
                ],
                onChanged: dropdownCallback,
              ),
            ],
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
            ),
          ],
        ),
      ),
    );
  }
}
