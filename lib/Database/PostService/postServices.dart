import 'package:firebase_database/firebase_database.dart';

class PostServices {
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference _databaseReference;

  Map post;
  PostServices(this.post);
  addPost() {
    String PostDB = 'POSTS';
    _databaseReference = _firebaseDatabase.reference().child(PostDB);
    _databaseReference.push().set(post);
  }

  addComment() {
    String PostDB = 'POSTS';
    _databaseReference =
        _firebaseDatabase.reference().child(PostDB).child('Comments');
    _databaseReference.push().set(post);
  }
}
