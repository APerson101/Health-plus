import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/Database/DataBaseHelper.dart';
import 'package:health_plus/models/Post.dart';
import 'package:health_plus/Database/Upvotes.dart';

class SocialMedia extends StatelessWidget {
  String text;
  static bool newUser = false;
  SocialMedia(this.text);
  @override
  Widget build(BuildContext context) {
    return SocialHome();
  }
}

class SocialHome extends StatefulWidget {
  SocialHome();
  @override
  _SocialHomeState createState() => _SocialHomeState();
}

class _SocialHomeState extends State<SocialHome> {
//   DataBaseHelper dataBaseHelper;
  DatabaseReference userInfoDBRef;

//   @override
//   void initState() {
  // userInfoDBRef = FirebaseDatabase.instance.reference().child("POSTS");
//     super.initState();
//   }

//   @override
  Widget build(BuildContext context) {
    return Container();
    //   child: FutureBuilder(
    //     future: userInfoDBRef.once(),
    //     builder: (context, snapshot) => userbuilder(context, snapshot),
    //   ),
    // );
  }
}
//   newUserWidget() {
//     return Container(
//       height: 0,
//     );
//   }

//   returningUserWidget() {
//     return Container(
//       height: 0,
//     );
//   }

//   Widget messageCard(Post item) {
//     int currentVotes;
//     Firestore.instance
//         .collection("Upvotes")
//         .getDocuments()
//         .then((QuerySnapshot snapshot) {
//       // currentVotes=f.data['Upvotes'];
//       snapshot.documents.forEach((f) => print('${f.data['Upvotes']}}'));
//     });

//     List<UpVotes> docs = List();
//     return StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance.collection('Upvotes').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return LinearProgressIndicator();
//           } else {
//             if (snapshot.hasData &&
//                 snapshot.connectionState == ConnectionState.active) {
//               // print(snapshot.data.documents);
//               for (var item in snapshot.data.documents) {
//                 docs.add(UpVotes.fromSnapshot(item));
//               }
//             }
//             return Column(
//               children: <Widget>[
//                 Text(item.date),
//                 Text(item.text),
//                 Text(item.title),
//                 Text(item.groupID),
//                 OutlineButton(
//                     child: Row(
//                       children: <Widget>[
//                         Text('upvote'),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(currentVotes.toString()),
//                       ],
//                     ),
//                     onPressed: upVotePressed),
//                 OutlineButton(child: Text('save'), onPressed: savePressed),
//                 OutlineButton(
//                     child: Text('comment'), onPressed: commentPressed),
//                 SizedBox(height: 30)
//               ],
//             );
//           }
//         });
//   }

//   getUserGroups() {
//     List<DataSnapshot> he = List();
//     FirebaseDatabase.instance
//         .reference()
//         .child("USERINFO")
//         .onValue
//         .forEach((element) {
//       he.add(element.snapshot);
//       print(element.snapshot.value['hjgHGHJG786HGFHGHJG']);
//     });
//     print(he.length);
//   }

//   userbuilder(BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
//     return questionCard();
//     return FirebaseAnimatedList(
//       query: userInfoDBRef,
//       itemBuilder: (context, snapshot, animation, index) {
//         //Check the ones that the user is subscribed too.
//         getUserGroups();
//         FutureBuilder(
//           future:
//               FirebaseDatabase.instance.reference().child("USERINFO").once(),
//           builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//             print('we are here');
//             if (snapshot.hasData) {
//               print(snapshot.data.value);
//               return Container(height: 0);
//             }
//             print('yeah nothing here');
//             return Container(height: 0);
//           },
//         );
//         return Container(height: 0);
//         // return messageCard(Post.fromSnapshot(snapshot));
//       },
//     );
//   }

//   void savePressed() {
//     //this is where firestore comes in
//   }

//   void upVotePressed() async {
//     //this is where firestore comes in
//     //determine whether it has bee
//     await Firestore.instance
//         .collection('Upvotes')
//         .document('theonlooker2020')
//         .setData({'PostID': 'Derinder', 'Upvotes': 554});

//     print('successful');

//     //try and update now
//     try {
//       //get current number
//       Firestore.instance
//           .collection('Upvotes')
//           .document('theonlooker2020')
//           .updateData({'Upvotes': 'Head First Flutter'});
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void commentPressed() {
//     //havent figured this one out yet
//   }

//   Widget questionCard() {
//     return Container(
//         height: 125,
//         child: Card(
//           margin: EdgeInsets.all(5),
//           clipBehavior: Clip.antiAlias,
//           child: InkWell(
//             onTap: () => Navigator.pushNamed(context, '/groupDetails'),
//             child: Column(
//               children: <Widget>[topicCard(), bottomRowQuestionCard()],
//             ),
//           ),
//           // color: Colors.blue,
//         ));
//   }

//   Widget topicCard() {
//     return Padding(
//       padding: EdgeInsets.all(7),
//       child: Text(
//         'Hello, I have a question regarding Mental Health in Nigeria, is there anyone available to answer, i undestand if there is no one, i just dont want to go to the hospital yet',
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(fontWeight: FontWeight.bold),
//         maxLines: 3,
//       ),
//     );
//   }

//   Widget bottomRowQuestionCard() {
//     return Container(
//       child: Row(
//         textDirection: TextDirection.rtl,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           FlatButton.icon(
//               label: Text('save'),
//               icon: Icon(Icons.label_outline),
//               onPressed: () => print('save pressed')),
//           FlatButton.icon(
//               label: Text('1.2k'),
//               icon: Icon(Icons.arrow_upward),
//               onPressed: () => print('vote pressed')),
//           FlatButton.icon(
//               onPressed: () => print('comment pressed'),
//               icon: Icon(Icons.comment),
//               label: Text('221')),
//           Text('General Group')
//         ],
//       ),
//     );
//   }
// }
