import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  String text;
  Profile(this.text);
  @override
  Widget build(BuildContext context) {
    final header = UserAccountsDrawerHeader(
        accountName: Text('first Last'), accountEmail: Text('name@gmail.com'));
    final profileDrawer = ListView(
      children: <Widget>[
        header,
        ListTile(
          title: Text('Page 1'),
        ),
        ListTile(
          title: Text('page 2'),
        ),
        ListTile(
          title: Text('page 3'),
        ),
      ],
    );
    return Scaffold(
      drawer: profileDrawer,
    );
  }
}
