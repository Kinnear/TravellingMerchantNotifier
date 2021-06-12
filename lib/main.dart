import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:travellingmerchantnotifier/data%20_classes/data_classes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:travellingmerchantnotifier/settings_layouts/settings_layout.dart';

Future<List<int>> loadSelectedList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> notifyOnStockList =
      (prefs.getStringList('notifyOnStockList') ?? []);

  // userSelectedStocksToNotify =
  List<int> retrievedIntList =
      notifyOnStockList.map((e) => int.parse(e)).toList();
  return retrievedIntList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<int> userSelectedStockList = await loadSelectedList();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DataStore(userSelectedStockList),
      )
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
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
  @override
  void initState() {
    super.initState();
  }

  Future<List<int>> loadSelectedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifyOnStockList =
        (prefs.getStringList('notifyOnStockList') ?? []);

    // userSelectedStocksToNotify =
    List<int> retrievedIntList =
        notifyOnStockList.map((e) => int.parse(e)).toList();
    return retrievedIntList;
  }

  String dateDisplay(int daysInTheFuture) {
    return DateFormat('MMM d, EEE')
        .format(DateTime.now().add(Duration(days: daysInTheFuture)));
  }

  bool highlightUserChosenStock(
      STOCK_ITEM stock, List<STOCK_ITEM> userPreferredList) {
    if (userPreferredList != null) {
      if (userPreferredList.contains(stock)) {
        return true;
      }
    }

    return false;
  }

  List<DataRow> buildDatatable(
      List<List<STOCK_ITEM>> futureStockItems, List<int> userPreferredIntList) {
    List<STOCK_ITEM> userPreferredStockList = [];

    if (userPreferredIntList != null) {
      for (int i = 0; i < userPreferredIntList.length; i++) {
        userPreferredStockList.add(STOCK_ITEM.values[userPreferredIntList[i]]);
      }
    }

    // print("userPreferredIntList: " + userPreferredIntList.toString());
    // print("userPreferredStockList: " + userPreferredStockList.toString());

    return [
      for (int i = 0; i < futureStockItems.length; i++) ...[
        DataRow(
          color: i == 0
              ? MaterialStateProperty.all(Colors.green)
              : MaterialStateProperty.all(Colors.transparent),
          cells: [
            DataCell(Text(
              i == 0 ? 'Today:' : dateDisplay(i),
              style: TextStyle(
                color: i == 0 ? Colors.white : Colors.black,
              ),
            )),
            DataCell(
              Chip(
                labelPadding: EdgeInsets.all(2.0),
                avatar: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Image.asset('assets/images/stock_items/' +
                      futureStockItems[i][0].imageURL),
                ),
                label: Text(
                  futureStockItems[i][0].text,
                  style: TextStyle(
                    color: i == 0 ? Colors.white : Colors.white,
                  ),
                ),
                // backgroundColor: i == 0 ? Colors.blue : Colors.black,
                backgroundColor: highlightUserChosenStock(
                        futureStockItems[i][0], userPreferredStockList)
                    ? Colors.blue
                    : Colors.black,
                elevation: 6.0,
                shadowColor: Colors.grey[60],
                padding: EdgeInsets.all(8.0),
              ),
            ),
            DataCell(
              Chip(
                labelPadding: EdgeInsets.all(2.0),
                avatar: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Image.asset('assets/images/stock_items/' +
                      futureStockItems[i][1].imageURL),
                ),
                label: Text(
                  futureStockItems[i][1].text,
                  style: TextStyle(
                    color: i == 0 ? Colors.white : Colors.white,
                  ),
                ),
                // backgroundColor: i == 0 ? Colors.blue : Colors.black,
                backgroundColor: highlightUserChosenStock(
                        futureStockItems[i][1], userPreferredStockList)
                    ? Colors.blue
                    : Colors.black,
                elevation: 6.0,
                shadowColor: Colors.grey[60],
                padding: EdgeInsets.all(8.0),
              ),
            ),
            DataCell(
              Chip(
                labelPadding: EdgeInsets.all(2.0),
                avatar: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Image.asset('assets/images/stock_items/' +
                      futureStockItems[i][2].imageURL),
                ),
                label: Text(
                  futureStockItems[i][2].text,
                  style: TextStyle(
                    color: i == 0 ? Colors.white : Colors.white,
                  ),
                ),
                // backgroundColor: i == 0 ? Colors.blue : Colors.black,
                backgroundColor: highlightUserChosenStock(
                        futureStockItems[i][2], userPreferredStockList)
                    ? Colors.blue
                    : Colors.black,
                elevation: 6.0,
                shadowColor: Colors.grey[60],
                padding: EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dataStore = context.watch<DataStore>();

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
                            rows: buildDatatable(dataStore.futureStockItems,
                                dataStore.userSelectedStocksToNotify),
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
            SettingsLayout(),
          ],
        ),
      ),
    );
  }
}
