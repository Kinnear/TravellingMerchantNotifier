import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:travellingmerchantnotifier/settings_layouts/stock_choice_layout.dart';

class SettingsLayout extends StatefulWidget {
  SettingsLayout({Key key}) : super(key: key);

  @override
  _SettingsLayoutState createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
      physics: BouncingScrollPhysics(),
      sections: [
        SettingsSection(
          title: 'Settings',
          tiles: [
            SettingsTile(
              title: 'Select stock items',
              leading: Icon(Icons.list),
              onPressed: (BuildContext context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return StockChoiceLayout();
                  }),
                );
              },
            ),
            // SettingsTile.switchTile(
            //   title: 'Use fingerprint',
            //   leading: Icon(Icons.fingerprint),
            //   switchValue: true,
            //   onToggle: (bool value) {},
            // ),
          ],
        ),
      ],
    );
  }
}
