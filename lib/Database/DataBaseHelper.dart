// import 'package:firebase_database/firebase_database.dart';
// import 'package:health_plus/HomePages/socialMedia.dart';

// import '../models/Post.dart';

// class DataBaseHelper {
//   DatabaseReference userInfoDBRef;
//   List<Post> grpMessages;

//   FirebaseDatabase groupMessages;
//   DataBaseHelper() {
//     groupMessages = FirebaseDatabase.instance;
//     grpMessages = List<Post>();
//     userInfoDBRef.onChildAdded.listen((event) {
//       _childAdded(event);
//     });

//     groupMessages.reference().child("POSTS").onChildAdded.listen((event) {
//       _groupListener(event);
//     });
//   }

//   void _childAdded(Event event) {
//     print(event.snapshot.key);
//     if (event.snapshot == null) {
//       // print('i found' + event.snapshot.toString());
//       // print('user hasnt joined any groups');
//       SocialMedia.newUser = true;

//       //Display Widget about adding groups

//     } else
//     //take user to home
//     {
//       SocialMedia.newUser = false;
//       print(event.snapshot.key);
//     }
//   }

//   void _groupListener(Event event) {
//     // print(event.snapshot.value);

//     // if (event.snapshot.value['GroupID'] == 'Group 3' ||
//     //     event.snapshot.value['GroupID'] == 'Group 4') {

//     // grpMessages.add(Post.fromSnapshot(event.snapshot));
//     // print(grpMessages.length);
//     // }
//   }

//   void Initialize() {}
// }
