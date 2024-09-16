import 'package:barber_shop/Provider/provider.dart';
import 'package:barber_shop/screens/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [],
      ),
      drawer: DrawerWidget(),
      body:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
              trailing: Switch(
                  value: notifier.isdark,
                  onChanged: (value) => notifier.changeTheme()),
            )
          ],
        );
      }),
    );
  }
}
