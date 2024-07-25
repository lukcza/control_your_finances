import 'package:control_your_finances/service/bank_account_model.dart';
import 'package:control_your_finances/service/database_service.dart';
import 'package:control_your_finances/views/home_view.dart';
import 'package:flutter/material.dart';

class AddAcountNumberView extends StatefulWidget {
  const AddAcountNumberView({Key? key}) : super(key: key);

  @override
  State<AddAcountNumberView> createState() => _AddAcountNumberViewState();
}

class _AddAcountNumberViewState extends State<AddAcountNumberView> {
  @override
  late DatabaseService databaseService;
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseService = DatabaseService.instance;
  }

  @override
  Widget build(BuildContext context) {
    final numberController = TextEditingController();
    final nameController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
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
                onPressed: () {
                  addBankAccount(nameController.text, numberController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
                child: Text("Add your new account"))
          ],
        ),
      ),
    );
  }
}

Future addBankAccount(String name, String accountNumber) =>
    DatabaseService.instance.createBankAccount(
        BankAccountModel(name: name, accountNumber: accountNumber));
