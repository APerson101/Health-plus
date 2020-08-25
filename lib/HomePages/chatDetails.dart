import 'package:flutter/material.dart';

class GroupDetails extends StatefulWidget {
  GroupDetails();
  @override
  _GroupDetailsState createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: conversationBody(),
    );
  }

  conversationBody() {
    return Column(
      children: <Widget>[
        //Questions and answers
        fullQuestion(),
        Row(
          children: <Widget>[
            Expanded(child: Divider()),
            Text(
              'comments',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w200),
            ),
            Expanded(child: Divider())
          ],
        ),
        commentsList()
      ],
    );
  }

  fullQuestion() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            'This is the full Topic in case you were wondering about it though',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(7),
          child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
        ),
      ],
    );
  }

  commentsList() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
              onPressed: null, icon: Icon(Icons.thumb_up), label: Text('21')),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(4),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
          ))
        ],
      ),
    );
  }
}
