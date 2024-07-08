import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FrequencyView extends StatefulWidget {
  FrequencyView({Key? key}) : super(key: key);

  @override
  State<FrequencyView> createState() => _FrequencyViewState();
}

class _FrequencyViewState extends State<FrequencyView> {
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
      print(_selectedFrequency);
    }
  }

  //title
  TextEditingController titleController = TextEditingController();
  //amunt
  TextEditingController amountController = TextEditingController();
  //Date selection
  @override
  String? toDayFormated;
  TextEditingController dateController = TextEditingController();
  final formatYMD = DateFormat(
    'dd/MM/yy HH:mm',
  );
  void initState() {
    // TODO: implement initState

    DateTime now = DateTime.now();
    toDayFormated = formatYMD.format(now);
    super.initState();
  }

  /*//calendar
  List<DateTime> selectedDates = [];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.title),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxWidth: 200),
                    hintText: "Title",

                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_money),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: const InputDecoration(
                    constraints: BoxConstraints(maxWidth: 200),
                    hintText: "Amount to pay",
                    suffixText: "zł"
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2028));
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: 0, minute: 0));
                    if (pickedDate == null || pickedTime == null) {
                      setState(() {
                        dateController.text = "";
                      });
                    } else {
                      pickedDate = pickedDate.copyWith(
                          hour: pickedTime.hour, minute: pickedTime.minute);
                      setState(() {
                        dateController.text = formatYMD.format(pickedDate!);
                      });
                    }
                  },
                  icon: Icon(Icons.date_range),
                ),
                TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxWidth: 200),
                        hintText: toDayFormated,
                        labelText: "initial date"
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              ),
            ],
            /* CleanCalendar(
              datePickerCalendarView: DatePickerCalendarView.monthView,
              dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
              onCalendarViewDate: (DateTime calendarViewDate) {
                // print(calendarViewDate);
              },
              selectedDates: selectedDates,
              onSelectedDates: (List<DateTime> value) {
                DateTime startDate = value.first;
                setState(() {
                    if (selectedDates.contains(startDate)) {
                      selectedDates.remove(startDate);
                      print(startDate);
                    } else {
                      if(isAutoFrequencyChecked==false) {
                        selectedDates.add(startDate);
                      }else{
                        switch(_selectedFrequency){
                          case "Daily":
                            DateTime endDate = DateTime(startDate.year+1, startDate.month, 1).subtract(Duration(days: 1));
                            while(startDate.isBefore(endDate)||startDate.isAtSameMomentAs(endDate)){
                              selectedDates.add(startDate);
                              startDate = startDate.add(Duration(days:1));
                            }
                            break;
                          case "Weekly":
                            DateTime endDate = DateTime(startDate.year+1, startDate.month, 1).subtract(Duration(days: 1));
                            while(startDate.isBefore(endDate)||startDate.isAtSameMomentAs(endDate)){
                              selectedDates.add(startDate);
                              startDate = startDate.add(Duration(days:7));
                            }
                            break;
                          case "Monthly":
                            DateTime endDate = DateTime(startDate.year+1, startDate.month, 1).subtract(Duration(days: 1));
                            while(startDate.isBefore(endDate)||startDate.isAtSameMomentAs(endDate)){
                              selectedDates.add(startDate);
                              startDate = new DateTime(startDate.year, startDate.month+1,startDate.day);
                            }
                            break;
                        }
                      }
                    }
                });
                print(selectedDates);
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
