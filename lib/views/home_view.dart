import 'package:control_your_finances/service/database_service.dart';
import 'package:control_your_finances/service/item_model.dart';
import 'package:control_your_finances/widgets/drawer.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          FutureBuilder<List<ItemModel>>(
              future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No items found'));
              } else {
                final items = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      print(item.title);
                      return Column(
                        children: [
                          ListTile(
                            title: Text(item.title),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },),],
      ),
      drawer: DefaultDarwer(),
    );
  }
}
