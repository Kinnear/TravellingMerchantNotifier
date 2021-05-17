import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travellingmerchantnotifier/data%20_classes/data_classes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Travelling Merchant Checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<STOCK_ITEM>> futureStockItems = [];

  @override
  void initState() {
    super.initState();

    futureStockItems.clear();

    for (int i = 0; i < 7; i++) {
      DayStock futureDayStock = new DayStock();
      futureStockItems.add(
        futureDayStock
            .calculatedDayStock(DateTime.now().add(Duration(days: i))),
      );
    }
  }

  // void _incrementCounter() {
  //   setState(() {});
  // }
  //
  String dateDisplay(int daysInTheFuture) {
    return DateFormat('EEE, MMM d')
        .format(DateTime.now().add(Duration(days: daysInTheFuture)));
  }

  List<DataRow> buildDatatable() {
    return [
      for (int i = 0; i < futureStockItems.length; i++) ...[
        DataRow(
          cells: [
            DataCell(Text(i == 0 ? 'Today:' : dateDisplay(i))),
            DataCell(
              Text(
                futureStockItems[i][0].text,
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            DataCell(
              Text(
                futureStockItems[i][1].text,
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            DataCell(
              Text(
                futureStockItems[i][2].text,
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          ],
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Future Forecast",
                icon: Icon(
                  Icons.addchart_rounded,
                ),
              ),
              Tab(
                text: "Notifier",
                icon: Icon(
                  Icons.access_alarms_rounded,
                ),
              ),
            ],
          ),
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 10.0,
                            columns: [
                              DataColumn(label: Text("Date")),
                              DataColumn(label: Text("Slot A")),
                              DataColumn(label: Text("Slot B")),
                              DataColumn(label: Text("Slot C")),
                            ],
                            rows: buildDatatable(),
                          ),
                        ),
                      ),
                      // Image.asset('assets/images/stock_items/barrel_of_bait.png'),
                    ],
                  ),
                  // Text(
                  //   'testing testing',
                  //   style: Theme.of(context).textTheme.headline4,
                  // ),
                ],
              ),
            ),
            Center(
              child: Container(),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
