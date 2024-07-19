import 'package:control_your_finances/views/home_view.dart';
import 'package:flutter/material.dart';
class AddAcountNumberView extends StatefulWidget {
  const AddAcountNumberView({Key? key}) : super(key: key);

  @override
  State<AddAcountNumberView> createState() => _AddAcountNumberViewState();
}

class _AddAcountNumberViewState extends State<AddAcountNumberView> {

  @override
  Widget build(BuildContext context) {
    final numberController = TextEditingController();
    final nameController = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "name of your bank account",
            ),
          ),
          TextField(
            controller: numberController,
            decoration: InputDecoration(
                hintText: "new bank account nummber",
            ),
          ),
          OutlinedButton(
              onPressed: ()=>Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>HomeView()),
              ),
              child: Text("Add your new account"))
        ],
      ),
    );
  }
}
