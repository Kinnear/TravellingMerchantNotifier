import 'package:flutter/material.dart';

class StockChoiceLayout extends StatefulWidget {
  StockChoiceLayout({Key key}) : super(key: key);

  @override
  _StockChoiceLayoutState createState() => _StockChoiceLayoutState();
}

class _StockChoiceLayoutState extends State<StockChoiceLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('Pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
