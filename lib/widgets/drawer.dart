import 'package:control_your_finances/views/frequency_view.dart';
import 'package:flutter/material.dart';

class DefaultDarwer extends StatelessWidget {
  const DefaultDarwer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.note_add),
            title: Text("Add note"),
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
