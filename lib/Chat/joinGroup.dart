import 'package:flutter/material.dart';

class JoinGroup extends StatefulWidget {
  JoinGroup();
  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Join Group"),
        ),
        body: availableGroups(),
      ),
    );
  }

  availableGroups() {
    return SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            //Radio buttons of groups
            ListView(
              children: <Widget>[],
            ),
            //Join Button
            RaisedButton(onPressed: () => {print("Join button pressed")})
          ],
        ));
  }
}
