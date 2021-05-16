import 'package:flutter/material.dart';
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
  List<STOCK_ITEM> dayStockItems = [];

  @override
  void initState() {
    super.initState();

    DayStock stockForToday = new DayStock();
    dayStockItems = stockForToday.calculatedDayStock(
      DateTime.now().add(
        const Duration(
          days: 1,
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {});
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
                      Text(
                        'Today\'s:',
                      ),
                      Text(
                        dayStockItems[0].text,
                      ),
                      Text(
                        dayStockItems[1].text,
                      ),
                      Text(
                        dayStockItems[2].text,
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
