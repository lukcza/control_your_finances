import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class SummaryView extends StatefulWidget {
  SummaryView({Key? key, required this.title, required this.date})
      : super(key: key);
  String title;
  DateTime date;

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late String nextDate;
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
                  margin: EdgeInsets.only(left: 20,bottom: 20),
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
                    margin: EdgeInsets.fromLTRB(20, 70, 20,0),
                    elevation: 30,
                    child: Column(children: [
                      if (widget.title != null && widget.date != null) ...[
                        Text(widget.title),
                        Text(DateFormat('dd/MM/yy HH:mm',).format(widget.date)),
                        Text(widget.title),
                      ]
                    ]),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
