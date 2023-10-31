import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();

    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = new DarwinInitializationSettings();

    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);

    // For android 13 and above permission request
    localNotification.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
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
          color: MaterialStateProperty.all(Colors.transparent),
          cells: [
            DataCell(Text(
              i == 0 ? 'Today:' : dateDisplay(i),
              style: TextStyle(
                color: Colors.black,
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
                    color: highlightUserChosenStock(
                            futureStockItems[i][0], userPreferredStockList)
                        ? Colors.white
                        : Colors.white,
                  ),
                ),
                backgroundColor: highlightUserChosenStock(
                        futureStockItems[i][0], userPreferredStockList)
                    ? Colors.blue
                    : Colors.black54,
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
                    color: highlightUserChosenStock(
                            futureStockItems[i][1], userPreferredStockList)
                        ? Colors.white
                        : Colors.white,
                  ),
                ),
                backgroundColor: highlightUserChosenStock(
                        futureStockItems[i][1], userPreferredStockList)
                    ? Colors.blue
                    : Colors.black54,
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
                    color: highlightUserChosenStock(
                            futureStockItems[i][2], userPreferredStockList)
                        ? Colors.white
                        : Colors.white,
                  ),
                ),
                backgroundColor: highlightUserChosenStock(
                        futureStockItems[i][2], userPreferredStockList)
                    ? Colors.blue
                    : Colors.black54,
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

  Future _showStockNotification(String notificationBody) async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "Local Notification", 
      channelDescription: "This is the description of the notification",
      importance: Importance.high
    );

    var iosDetails = new DarwinNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotification.show(0, "Visit Travelling Merchant",
        notificationBody, generalNotificationDetails);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Pressed the floating action notification button");
            _showStockNotification(
                "Items: Gift of the Reaper and Anima Crystal are on");
          },
          child: Icon(
            Icons.notifications,
          ),
        ),
      ),
    );
  }
}
