import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String content, username, key;
  int likes_count;
  Timestamp date_posted;

  static const CONTENT = 'content';
  static const DATE_POSTED = 'date_posted';
  static const LIKES_COUNT = 'likes_count';
  static const USERNAME = 'username';

  Comment(this.content, this.date_posted, this.likes_count, this.username);

  Map<String, dynamic> toJSON() {
    return {
      CONTENT: content,
      DATE_POSTED: date_posted,
      LIKES_COUNT: likes_count,
      USERNAME: username
    };
  }

  Map<String, dynamic> toFxnJSON() {
    return {
      CONTENT: content,
      DATE_POSTED: null,
      LIKES_COUNT: likes_count,
      USERNAME: username
    };
  }

  Comment.fromSnapShot(QueryDocumentSnapshot snap)
      : this.key = snap.id,
        this.content = snap.data()[CONTENT],
        this.date_posted = snap.data()[DATE_POSTED],
        this.likes_count = snap.data()[LIKES_COUNT],
        this.username = snap.data()[USERNAME];
}
