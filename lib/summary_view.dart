import 'package:flutter/material.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Column(
                children: [
              if (widget.title != null && widget.date != null) ...[
                Text(widget.title),
                Text(widget.title),
                Text(widget.title),
              ]
            ]),
          )
        ],
      ),
    );
  }
}
