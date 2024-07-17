import 'package:flutter/material.dart';

import '../service/database_service.dart';
import '../service/item_model.dart';
import 'package:intl/intl.dart';

import '../widgets/drawer.dart';
class ListOfItems extends StatefulWidget {
  const ListOfItems({Key? key}) : super(key: key);

  @override
  State<ListOfItems> createState() => _ListOfItemsState();
}

class _ListOfItemsState extends State<ListOfItems> {
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
    return Scaffold(
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
                            subtitle: Text("Notfication: "+DateFormat(
                              'dd/MM/yy HH:mm',
                            ).format(item.nextDate)),
                            onTap: ()=>showDialog<String>(
                              context: context,
                              builder: (BuildContext context)=>Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(item.title),
                                      Text(item.id.toString()),
                                      Text(item.frequency),
                                      Text("Start Notify: "+DateFormat(
                                        'dd/MM/yy HH:mm',
                                      ).format(item.startDate)),
                                      Text("Next Notify: "+DateFormat(
                                        'dd/MM/yy HH:mm',
                                      ).format(item.nextDate)),

                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(onPressed: ()=>print('tap'), icon: Icon(Icons.delete)),
                                          IconButton(onPressed: ()=>print('tap'), icon: Icon(Icons.edit)),
                                          IconButton(onPressed: ()=>print('tap'), icon: Icon(Icons.copy)),
                                        ],)
                                    ],
                                  ),
                                ),
                              )
                            ),
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
