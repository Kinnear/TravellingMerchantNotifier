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
    child: MyApp(),
  ));
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

  List<DataRow> buildDatatable(List<List<STOCK_ITEM>> futureStockItems) {
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
              Text(
                futureStockItems[i][0].text,
                style: TextStyle(
                  fontSize: 10.0,
                  color: i == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
            DataCell(
              Text(
                futureStockItems[i][1].text,
                style: TextStyle(
                  fontSize: 10.0,
                  color: i == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
            DataCell(
              Text(
                futureStockItems[i][2].text,
                style: TextStyle(
                  fontSize: 10.0,
                  color: i == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dataStore = context.read<DataStore>();

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
                            rows: buildDatatable(dataStore.futureStockItems),
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
