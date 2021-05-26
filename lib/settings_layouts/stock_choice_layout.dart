import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellingmerchantnotifier/data%20_classes/data_classes.dart';

class StockChoiceLayout extends StatefulWidget {
  StockChoiceLayout({Key key}) : super(key: key);

  @override
  _StockChoiceLayoutState createState() => _StockChoiceLayoutState();
}

class _StockChoiceLayoutState extends State<StockChoiceLayout> {
  @override
  Widget build(BuildContext context) {
    final dataStore = context.read<DataStore>();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Select stock items to be notified on:",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: STOCK_ITEM.values.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      selected:
                          dataStore.userSelectedStocksToNotify.contains(index),
                      selectedTileColor: Colors.green,
                      title: Text(
                        STOCK_ITEM.values[index].text,
                        style: TextStyle(
                          color: dataStore.userSelectedStocksToNotify
                                  .contains(index)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (dataStore.userSelectedStocksToNotify
                              .contains(index)) {
                            dataStore.userSelectedStocksToNotify
                                .removeWhere((val) => val == index);
                          } else {
                            dataStore.userSelectedStocksToNotify.add(index);
                          }
                        });

                        dataStore.saveSelectedList(
                            dataStore.userSelectedStocksToNotify);

                        print("Selected Indexes in list: " +
                            dataStore.userSelectedStocksToNotify.toString());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        //  FlatButton(
        //   child: Text('Pop!'),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
    );
  }
}
