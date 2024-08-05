import 'package:control_your_finances/service/bank_account_model.dart';
import 'package:control_your_finances/service/database_service.dart';
import 'package:control_your_finances/views/add_bank_account_view.dart';
import 'package:intl/intl.dart';
import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'summary_view.dart';
import '../resources/frequency_enum.dart';

class FrequencyView extends StatefulWidget {
  FrequencyView({Key? key}) : super(key: key);

  @override
  State<FrequencyView> createState() => _FrequencyViewState();
}

class _FrequencyViewState extends State<FrequencyView> {
  Future<List<BankAccountModel>>? bankAccountList;
  late String selectedAccount;
  BankAccountModel? firstElement;
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

  //TODO: create a data validation for form
  //title
  TextEditingController titleController = TextEditingController();
  //amunt
  TextEditingController amountController = TextEditingController();
  //Date selection
  @override
  String? toDayFormated;
  TextEditingController dateController = TextEditingController();
  late DateTime lastFormOfDate;
  final formatYMD = DateFormat(
    'dd/MM/yy HH:mm',
  );
  //auto
  void initState() {
    DateTime now = DateTime.now();
    toDayFormated = formatYMD.format(now);
    dateController.text = toDayFormated!;
    lastFormOfDate = DateTime.now();
    bankAccountList = DatabaseService.instance.readAllBankAccounts();
    selectedAccount = "null";
    bankAccountList?.then((list) {
      if (list.isNotEmpty) {
        setState(() {
          selectedAccount = list[0].name;
        });
      }else{
        selectedAccount = "null";
      }
    });
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
          children: [
            selectedAccount != null?
              Container(
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
                              suffixText: "zł"),
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
                                  hour: pickedTime.hour,
                                  minute: pickedTime.minute);
                              lastFormOfDate = pickedDate;
                              setState(() {
                                dateController.text =
                                    formatYMD.format(pickedDate!);
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
                                labelText: "initial date")),
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
                    FutureBuilder(
                        future: bankAccountList,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<BankAccountModel> data = snapshot.data;
                            return DropdownButton(
                                value: selectedAccount,
                                items: data.map((BankAccountModel account) {
                                  return DropdownMenuItem<String>(
                                    child: Text(account.name),
                                    value: account.name,
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedAccount = newValue!;
                                  });
                                });
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    if (isAutoFrequencyChecked != false) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            value: _selectedFrequency,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Daily"),
                                value: "Daily",
                              ),
                              DropdownMenuItem(
                                child: Text("Weekly"),
                                value: "Weekly",
                              ),
                              DropdownMenuItem(
                                child: Text("Monthly"),
                                value: "Monthly",
                              ),
                              DropdownMenuItem(
                                child: Text("Yearly"),
                                value: "Yearly",
                              ),
                            ],
                            onChanged: dropdownCallback,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              )
              /*Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SummaryView(
                                      title: titleController.text,
                                      date: lastFormOfDate,
                                      autoFrequencyType: _selectedFrequency,
                                      amount: double.parse(amountController.text),
                                    ))),
                        icon: Icon(Icons.arrow_forward_outlined))
                  ],
                ),
              ],
            ),*/
            : Container(
             child: Column(
               children: [
                 Text("You don't have any bank account added. Please add minimum two account (Sender and recipient)"),
                 OutlinedButton(
                   child: Text("Click to add"),
                   onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAcountNumberView()));
                   },
                 ),
               ],
             ),
           )
            ],
        ),
      ),
    );
  }
}
