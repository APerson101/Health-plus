// import 'package:flutter/material.dart';
// import 'package:health_plus/models/Post.dart';
// import 'package:health_plus/Database/PostService/postServices.dart';

// class GroupChat extends StatefulWidget {
//   GroupChat();
//   @override
//   _GroupChatState createState() => _GroupChatState();
// }

// class _GroupChatState extends State<GroupChat> {
//   static const menuItems = <String>[
//     'Group 1',
//     'Group 2',
//     'Group 3',
//     'Group 4',
//     'Group 5',
//     'Group 6'
//   ];

//   TextEditingController _textEditingController1 = TextEditingController();
//   TextEditingController _textEditingController2 = TextEditingController();

//   final List<DropdownMenuItem<String>> dropMenu = menuItems
//       .map((e) => DropdownMenuItem<String>(
//             value: e,
//             child: Text(e),
//           ))
//       .toList();
//   String buttonSelectedValue;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "New Message",
//           ),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: postMessage,
//               //  print("Button pressed"), //postMessage(buttonSelectedValue,
//               //_textEditingController1.text, _textEditingController2.text),
//               child: Text("POST"),
//             )
//           ],
//         ),
//         body: SafeArea(
//             minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 groupRow(),
//                 SizedBox(
//                   height: 25.0,
//                 ),
//                 titleRow(),
//                 SizedBox(
//                   height: 25.0,
//                 ),
//                 messageRow(),
//               ],
//             )),
//       ),
//     );
//   }

//   groupRow() {
//     return Row(
//       children: <Widget>[
//         Icon(
//           Icons.group,
//           color: Colors.grey,
//         ),
//         SizedBox(
//           width: 10.0,
//         ),
//         DropdownButton(
//           value: buttonSelectedValue,
//           hint: Text("Choose Group"),
//           items: dropMenu,
//           onChanged: (String value) {
//             setState(() {
//               buttonSelectedValue = value;
//             });
//           },
//         )
//       ],
//     );
//   }

//   messageRow() {
//     return TextFormField(
//       controller: _textEditingController1,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         hintText: "Describe the issue",
//         helperText: "Message would be replied to by verified doctors",
//         labelText: 'Message',
//       ),
//       maxLines: 3,
//     );
//   }

//   titleRow() {
//     return TextFormField(
//       controller: _textEditingController2,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         hintText: "Summary of post",
//         labelText: 'Title',
//       ),
//       maxLines: 1,
//     );
//   }

//   postMessage() {
//     if (buttonSelectedValue != null &&
//         _textEditingController1 != null &&
//         _textEditingController2 != null) {
//       if (buttonSelectedValue.length > 1 &&
//           _textEditingController1.text.length > 1 &&
//           _textEditingController2.text.length > 2) {
//         //update database, refresh and go back
//         print('group: ' +
//             buttonSelectedValue +
//             " title: " +
//             _textEditingController1.text +
//             " post: " +
//             _textEditingController2.text);

//         Post post = Post(
//             (DateTime.now().millisecondsSinceEpoch).toString(),
//             buttonSelectedValue,
//             _textEditingController1.text,
//             '1',
//             _textEditingController2.text);

//         PostServices _postService = PostServices(post.toJSON());

//         _postService.addPost();

//         Post comment = Post('today', 'group 3', 'no title',
//             'this is a comment in response to that post,', '4');
//         _postService = PostServices(comment.toJSON());
//         _postService.addComment();

//         Navigator.pop(context);
//       }
//     }
//   }
// }
