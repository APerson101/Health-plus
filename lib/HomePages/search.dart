import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Container(
        child: Center(
            child: Column(
          children: [
            Text(value.toString()),
            RaisedButton(onPressed: _counter),
          ],
        )),
      ),
    );
  }

  void _counter() {
    setState(() {
      value++;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
