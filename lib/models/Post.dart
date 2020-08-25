// import 'package:cloud_firestore/cloud_firestore.dart';

// class Post extends Equatable {
//   static const CONTENT = 'content';
//   static const USER = 'username';
//   static const DATE = 'date_posted';
//   static const COMMENTS = 'comments_count';
//   static const GROUP = 'group_name';
//   static const LIKES = 'likes_count';
//   static const TITLE = 'title';

//   String _content, _dateposted, _posterName, _groupName, _title, _key;
//   int _commentCount, _likesCount;

//   Post(this._dateposted, this._posterName, this._content, this._groupName,
//       this._title, this._commentCount, this._likesCount);

//   String get text => _content;
//   String get date => _dateposted;
//   String get posterName => _posterName;
//   String get groupName => _groupName;
//   int get commentCount => _commentCount;
//   int get likesCount => _likesCount;
//   String get title => _title;
//   String get key => _key;

//   Post.fromSnapshot(DocumentSnapshot snap)
//       : this._key = snap.id,
//         this._content = snap.data()[CONTENT],
//         this._dateposted = snap.data()[DATE],
//         this._posterName = snap.data()[USER],
//         this._groupName = snap.data()[GROUP],
//         this._commentCount = snap.data()[COMMENTS],
//         this._likesCount = snap.data()[LIKES],
//         this._title = snap.data()[TITLE];

//   Map toJSON() {
//     return {
//       TITLE: _title,
//       CONTENT: _content,
//       USER: _posterName,
//       DATE: _dateposted,
//       GROUP: _groupName,
//       LIKES: _likesCount,
//       COMMENTS: _commentCount
//     };
//   }
// }
