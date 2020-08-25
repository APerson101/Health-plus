import 'package:flutter/material.dart';

String buttonSelectedValue = 'Home';

Widget homeAppBar() {
  const menuItems = <String>['Home', 'Popular'];
  final List<DropdownMenuItem<String>> dropMenu = menuItems
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();
  // = 'Home';
  return AppBar(
    title: DropdownButton(
        items: dropMenu,
        value: buttonSelectedValue,
        onChanged: (String value) {
          // setState(() {
          //   buttonSelectedValue = value;
          // });
        }),
    actions: <Widget>[
      IconButton(icon: Icon(Icons.inbox), color: Colors.black, onPressed: null)
    ],
  );
}
