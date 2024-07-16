import 'package:control_your_finances/service/database_service.dart';
import 'package:control_your_finances/service/item_model.dart';
import 'package:flutter/material.dart';
import 'views/frequency_view.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DatabaseService databaseService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      databaseService = DatabaseService.instance;
    }catch(err){
      print('err');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:FrequencyView(),
    );
  }
}
