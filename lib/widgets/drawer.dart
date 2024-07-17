import 'package:control_your_finances/views/frequency_view.dart';
import 'package:flutter/material.dart';

class DefaultDarwer extends StatefulWidget {
  const DefaultDarwer({Key? key}) : super(key: key);

  @override
  State<DefaultDarwer> createState() => _DefaultDarwerState();
}

class _DefaultDarwerState extends State<DefaultDarwer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.calendar_today_outlined),
            title: Text("Add item"),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return  FrequencyView();
              }))
            },
          ),
        ],
      ),
    );
  }
}
