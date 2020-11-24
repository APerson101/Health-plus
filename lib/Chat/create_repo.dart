import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_plus/Chat/bloc/createpost_event.dart';
import 'package:health_plus/models/Post.dart';

class CreatePostRepo {
  CreatePostRepo();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final fireauth = FirebaseAuth.instance;

  Future<List<String>> fetchgroups() async {
    var docs = await _getGroupsDocs();
    var groups = _convertToGroups(docs);
    return groups;
  }

  Future _getGroupsDocs() async {
    if (_firestore != null) {
      var res = await _firestore.collection('Groups').get();
      var docs = res.docs;
      return docs;
    }
    return null;
  }

  _convertToGroups(List<QueryDocumentSnapshot> docs) {
    List<String> _groupNames = [];
    for (var item in docs) {
      _groupNames.add(item.data()['Name']);
    }
    return _groupNames;
  }

  savePost(SavePostEvent event) async {
    /**
     * get username
     */
    var doc = await _firestore
        .collection('Users')
        .doc(fireauth.currentUser.uid)
        .get();
    var username = doc.data()['username'];

    var _post = Post(event.timestamp, username, event.content, event.groupname,
        event.title, event.commentsCount, event.likesCount);
    var jsonPost = _post.toJSON();
    try {
      await _firestore.collection('Posts').add(jsonPost);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
