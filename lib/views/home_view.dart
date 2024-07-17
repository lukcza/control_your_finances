import 'package:control_your_finances/service/database_service.dart';
import 'package:control_your_finances/service/item_model.dart';
import 'package:control_your_finances/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DatabaseService databaseService;
  late Future<List<ItemModel>>  _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseService = DatabaseService.instance;
    _data = databaseService.readAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Text('home'),
    );
  }
}

