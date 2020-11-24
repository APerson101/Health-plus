import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/Chat/bloc/createpost.dart';
import 'package:health_plus/Chat/bloc/createpost_bloc.dart';
import 'package:health_plus/Chat/bloc/createpost_state.dart';

class GroupPost extends StatefulWidget {
  final List<String> userGroups;
  GroupPost({this.userGroups});
  @override
  _GroupPostState createState() => _GroupPostState();
}

class _GroupPostState extends State<GroupPost> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreatePostBloc>(create: (_) {
          var _bloc = CreatePostBloc();
          _bloc.add(StartEvent());
          return _bloc;
        }),
      ],
      child: PostUIbody(widget.userGroups),
    );
  }
}

class PostUIbody extends StatefulWidget {
  final List<String> userGroups;
  PostUIbody(this.userGroups);

  @override
  _PostUIbodyState createState() => _PostUIbodyState();
}

class _PostUIbodyState extends State<PostUIbody> {
  String buttonSelectedValue;
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePostBloc, CreatepostState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "New Post",
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: postMessage,
              child: Text("POST"),
            )
          ],
        ),
        body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                groupRow(state),
                SizedBox(
                  height: 25.0,
                ),
                titleRow(),
                SizedBox(
                  height: 25.0,
                ),
                messageRow(),
              ],
            )),
      );
    });
  }

  groupRow(CreatepostState state) {
    List<String> groups = widget.userGroups;

    // if (state is GroupFetchSuccess) {
    //   //fetching groups
    //   groups = state.groups;

    List<DropdownMenuItem<String>> dropMenu = groups
        .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ))
        .toList();

    return Row(
      children: <Widget>[
        Icon(
          Icons.group,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10.0,
        ),
        DropdownButton(
          value: buttonSelectedValue,
          hint: Text("Choose Group"),
          items: dropMenu,
          onChanged: (String value) {
            setState(() {
              buttonSelectedValue = value;
            });
          },
        )
      ],
    );
    // } else
    //   return Container(
    //     height: 0,
    //   );
  }

  messageRow() {
    return TextFormField(
      controller: _textEditingController1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Describe the issue",
        helperText: "Message would be replied to by verified doctors",
        labelText: 'Message',
      ),
      maxLines: 3,
    );
  }

  titleRow() {
    return TextFormField(
      controller: _textEditingController2,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Summary of post",
        labelText: 'Title',
      ),
      maxLines: 1,
    );
  }

  postMessage() {
    if (buttonSelectedValue != null &&
        _textEditingController1 != null &&
        _textEditingController2 != null) {
      if (buttonSelectedValue.length > 1 &&
          _textEditingController1.text.length > 1 &&
          _textEditingController2.text.length > 2) {
        BlocProvider.of<CreatePostBloc>(context).add(SavePostEvent(
          Timestamp.fromDate(DateTime.now()),
          _textEditingController1.text,
          buttonSelectedValue,
          _textEditingController2.text,
          0,
          0,
        ));

        Navigator.pop(context);
      }
    }
  }
}
