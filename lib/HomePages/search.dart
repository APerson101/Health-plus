import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  String text;
  Search(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(text)),
    );
  }
}
