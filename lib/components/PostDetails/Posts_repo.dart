import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_plus/components/Home_page/Home/Notifications.dart';
import 'package:health_plus/components/PostDetails/comment.dart';
import 'package:health_plus/models/Post.dart';

class PostsRepo {
  PostsRepo();
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CloudFunctions _cloudFunctions = CloudFunctions.instance;

  saveComment(String comment, Post post) async {
    var comment_ = await commentsTo(comment);
    var commentMap = comment_.toFxnJSON();
    var maxLength = comment.length >= 25 ? 25 : comment.length;
    var not = CommentPostNotification(
      post.groupName,
      ' ',
      ' ',
      comment_.date_posted,
      comment.substring(0, maxLength),
      NotificationType.addedComment,
    );
    var username = await getUserName();

    try {
      // _cloudFunctions.useFunctionsEmulator(origin: 'http://localhost:5001');
      // var result = await _cloudFunctions
      //     .getHttpsCallable(functionName: 'myUppercaseFunction')
      //     .call(<String, dynamic>{
      //   'PostID': post.key,

      var result = await _cloudFunctions
          .getHttpsCallable(functionName: 'addComment')
          .call(<String, dynamic>{
        'PostID': post.key,
        'comment': commentMap,
        'notification': not.toFunctionJSON(),
        'username': username,
        'seconds': comment_.date_posted.seconds,
        'nano': comment_.date_posted.nanoseconds,
      });
      print(result.data);
    } catch (e) {
      print(e);
    }
  }

  Future<Comment> commentsTo(String comment) async {
    var userID = FirebaseAuth.instance.currentUser.uid;
    var userDoc =
        await _firebaseFirestore.collection('Users').doc(userID).get();
    var username_ = userDoc.data()['username'];
    var comment_ =
        Comment(comment, Timestamp.fromDate(DateTime.now()), 0, username_);
    return comment_;
  }

  loadComments(Post post) async {
    var comments;
    try {
      comments = await _firebaseFirestore
          .collection('Posts')
          .doc(post.key)
          .collection('comments')
          .get();
    } catch (e) {
      print(e);
    }

    List<Comment> comments_post = List();
    for (var item in comments.docs) {
      var convert = Comment.fromSnapShot(item);
      comments_post.add(convert);
    }

    return comments_post;
  }

  getUserName() async {
    var uID = FirebaseAuth.instance.currentUser.uid;
    var userDoc = await _firebaseFirestore.collection('Users').doc(uID).get();
    var username_ = userDoc.data()['username'];
    return username_;
  }

  toggleLikePost(Post post) async {
    await _likePost(post);
    //notifications and likes count
    _firebaseFirestore
        .doc('Posts/${post.key}')
        .set({'count': FieldValue.increment(1)});
  }

  _likePost(Post post) async {
    var userId = FirebaseAuth.instance.currentUser.uid, postID = post.key;
    //if liked, unlike otherwise like, increase count?
    try {
      var likedComments =
          await _firebaseFirestore.collection('Likes/$userId/posts').get();
      List<QueryDocumentSnapshot> doccs = likedComments.docs;
      if (doccs != null && doccs.length > 0) {
        print('okay, user has liked somethings before now');
        for (var item in doccs) {
          print(item.id);
          if (item.id.contains(postID)) {
            _firebaseFirestore.doc('Likes/$userId/comments/$postID').delete();
            print('delete successs');
            return;
          }
        }
        {
          _firebaseFirestore
              .collection('Likes')
              .doc(userId)
              .collection('posts')
              .doc('$postID')
              .set({});
        }
      } else {
        print('user hasnt liked yet, creating...');
        _firebaseFirestore.collection('Likes').doc(userId).set({});
        _firebaseFirestore
            .collection('Likes')
            .doc(userId)
            .collection('posts')
            .doc('$postID')
            .set({});
      }
      return;
    } catch (e) {
      print(' e so burst');
    }
  }

  toggleLikeComment(String key) async {
    var userId = FirebaseAuth.instance.currentUser.uid, commentID = key;
    print('attemptinng to toggle like comment with $userId and $commentID');
    //if liked, unlike otherwise like, increase count?
    try {
      var likedComments =
          await _firebaseFirestore.collection('Likes/$userId/comments').get();
      List<QueryDocumentSnapshot> doccs = likedComments.docs;
      if (doccs != null && doccs.length > 0) {
        print('okay, user has liked somethings before now');
        for (var item in doccs) {
          print(item.id);
          if (item.id.contains(commentID)) {
            _firebaseFirestore
                .doc('Likes/$userId/comments/$commentID')
                .delete();
            print('delete successs');
            return;
          }
        }
        {
          _firebaseFirestore
              .collection('Likes')
              .doc(userId)
              .collection('comments')
              .doc('$commentID')
              .set({});
        }
      } else {
        print('user hasnt liked yet, creating...');
        _firebaseFirestore.collection('Likes').doc(userId).set({});
        _firebaseFirestore
            .collection('Likes')
            .doc(userId)
            .collection('comments')
            .doc('$commentID')
            .set({});
      }
      return;
    } catch (e) {
      print(' e so burst');
    }
  }
}
