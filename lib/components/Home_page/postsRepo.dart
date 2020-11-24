import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_plus/models/Post.dart';

class PostsRepository {
  PostsRepository();
  final firestore = FirebaseFirestore.instance;
  Future<List<Post>> getPosts({List<String> groups}) async {
    //1 get data from Firebase
    var result = await _getpostsFromDB(userGroups: groups);
    //2 convert data to post class
    //3 send converted data
    return result;
  }

  Future<List<String>> getUserGroups() async {
    if (firestore == null) return null;
    var userID = FirebaseAuth.instance.currentUser.uid;
    var userGroups = await _getGroupsIDsUser(userID);
    if (userGroups == null) {
      return null;
    } else
      return userGroups;
  }

  _getpostsFromDB({List<String> userGroups}) async {
    var postsDocsSnaps = await _getPostsfromFireBase(userGroups: userGroups);
    if (postsDocsSnaps != null) {
      //posts exists
      var listPosts = _mapPosts(postsDocsSnaps);
      return listPosts;
    } else
      return null;
  }

  Future<List<String>> _getGroupsIDsUser(String userID) async {
    var userDoc = await firestore.collection('Users').doc(userID).get();
    var username_ = userDoc.data()['username'];

    var userGroups =
        await firestore.collection('user_groups').doc(username_).get();
    //groupIDS user follows
    //iterate over the user_groups and detect null/empty and get the groupIDs
    if (userGroups != null && userGroups.exists) {
      var docsList = userGroups.data();
      List<String> groupNames = docsList['group_names'];
      return groupNames;
    } else {
      return null;
    }
  }

  _getPostsfromFireBase({List<String> userGroups}) async {
    Query postsQuery;
    if (userGroups != null) {
      postsQuery = firestore
          .collection('Posts')
          .where('group_name', whereIn: userGroups);
    } else if (userGroups == null) {
      postsQuery = firestore
          .collection('Posts')
          .orderBy('likes_count', descending: true)
          .limit(20);
    }

    var postsSnapShots = await postsQuery.get();

    var postDocs = postsSnapShots.docs;

    if (postDocs != null) {
      return postDocs;
    } else
      return null;
  }

  List<Post> _mapPosts(List<QueryDocumentSnapshot> postsDocsSnaps) {
    List<Post> _postsList = List();
    for (var item in postsDocsSnaps) {
      var _convertedDoc = Post.fromSnapshot(item);
      _postsList.add(_convertedDoc);
    }
    return _postsList;
  }

  determineGroups() async {
    return await getUserGroups();
  }
}
