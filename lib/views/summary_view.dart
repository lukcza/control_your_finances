import 'package:control_your_finances/service/database_service.dart';
import 'package:control_your_finances/views/items_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../service/item_model.dart';
import 'home_view.dart';

class SummaryView extends StatefulWidget {
  SummaryView(
      {Key? key,
      required this.title,
      required this.date,
      required this.amount,
      this.autoFrequencyType, required this.idBankAccountSender, required this.idBankAccountRecipients})
      : super(key: key);
  String title;
  DateTime date;
  int? idBankAccountSender;
  List<int?> idBankAccountRecipients;
  String? autoFrequencyType;
  double amount;
  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  late DateTime nextDate;
  void setNextDate() {
    if (widget.autoFrequencyType != null) {
      switch (widget.autoFrequencyType) {
        case "Daily":
          nextDate = widget.date.add(Duration(days: 1));
          break;
        case "Weekly":
          nextDate = widget.date.add(Duration(days: 7));
          break;
        case "Monthly":
          //nextDate = new DateTime(widget.date.year, widget.date.month+1, widget.date.day,)
          nextDate = widget.date.copyWith(month: widget.date.month + 1);
          break;
        case "Yearly":
          nextDate = widget.date.copyWith(year: widget.date.year + 1);
          break;
      }
    }
  }

  //database
  late DatabaseService databaseService;
  late ItemModel itemModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setNextDate();
    itemModel = ItemModel(
        idBankAccountSender: widget.idBankAccountSender,
        idBankAccountRecipients: widget.idBankAccountRecipients,
        title: widget.title,
        startDate: widget.date,
        nextDate: nextDate,
        amount: widget.amount,
        frequency: widget.autoFrequencyType!);
    try {
      databaseService = DatabaseService.instance;
    } catch (err) {
      print(err);
    }
  }

  @override
  void didUpdateWidget(covariant SummaryView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    "Your new Fianance",
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white60,
                    margin: EdgeInsets.fromLTRB(20, 70, 20, 0),
                    elevation: 30,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (widget.title != null &&
                                widget.date != null) ...[
                              Text(widget.title),
                              Text("First: " +
                                  DateFormat(
                                    'dd/MM/yy HH:mm',
                                  ).format(widget.date)),
                              Text("Next: " +
                                  DateFormat(
                                    'dd/MM/yy HH:mm',
                                  ).format(nextDate)),
                              if (widget.autoFrequencyType != null)
                                Text(widget.autoFrequencyType!),
                            ]
                          ]),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [BackButton()],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          databaseService.createItem(itemModel);
                          //print(databaseService.readItems(itemModel.id!));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListOfItems()));

                        },
                        icon: Icon(Icons.add)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
