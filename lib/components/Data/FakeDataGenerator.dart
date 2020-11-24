import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_plus/models/Post.dart';
import 'package:http/http.dart' as http;

class GenerateFakeData {
/**
 * Get list of random variables
 */

  GenerateFakeData();

  void main() {
    print('hello world');
  }

  final firestore = FirebaseFirestore.instance;
  final fireauth = FirebaseAuth.instance;
  final firestorage = FirebaseStorage;

  void createPosts() async {
    /**
     * get all users IDS to create postedby:
     * Generate random title and Content using APIs
     * all random Group
     * 
     */
    for (var i = 0; i < 50; i++) {
      await create();
    }
  }

  Future create() async {
    List<String> _userIDS = getUserIDS();
    var tAndC = await _getTitleAndContent();

    var _rand = Random();
    var comment_count = _rand.nextInt(240);
    var likes_count = _rand.nextInt(500);
    var groupInfo = await _getGroupInfo();
    var randUserID = _userIDS[_rand.nextInt(_userIDS.length - 1)];
    var datePosted = Timestamp.fromDate(DateTime.now());
    var _posterName = await getPosterName(randUserID);
    var _content, _title;
    tAndC.entries.forEach((element) {
      _title = element.key;
      _content = element.value;
    });
    var _groupName = groupInfo['Name'];

    var _newPost = Post(datePosted, _posterName, _content, _groupName, _title,
        comment_count, likes_count);
    _newPost.toString();
    uploadPost(_newPost);
  }

  getUserIDS() {
    return [
      '5IAhPe0TkLas7G9LYGbgP2h41Vk1',
      'dVlrDjPAJxggMv3rHoY5LVZJqPL2',
      '0A1UxlZOxuMTnukwDkS9r8F5eZR2',
      'IQopHPu6kfXgcaGEbMcvvn8KY2D2',
      'syUSg2x920U25MFgcb2HyJzykSc2',
      'CJmtsxP4iDgytfzc4Jowi0f0SRu2',
      'VMHENSZrPbPs08ehAxkcQDf4zv23',
      'CWtsKW9D5RM4uNf6uImZ95j9QPf2',
      'M68QDlYcnNfYLBUCx0oUjxF8vIM2',
      'UKC4finLhdZmyh2qDwXN6K409N72'
    ];
  }

  Future<Map<String, String>> _getTitleAndContent() async {
    Map<String, String> key = {'X-Api-Key': 'a3d5af840b8c49fca6e064342a6518b9'};
    var url = 'https://randommer.io/api/Text/LoremIpsum' +
        '?loremType=normal&type=words&number=100';
    final response = await http.get(url, headers: key);
    if (response.statusCode == 200) {
      String _textGenerated = json.decode(response.body);
      //break down into title and body;
      Random _rand = Random();
      int tt = _rand.nextInt(40);
      int titleCount = (tt * 5) + 1;
      var title = _textGenerated.substring(0, titleCount);
      var content = _textGenerated.substring(titleCount + 1);
      // print('title count: $tt');
      // print('title: $title');
      // print('content: $content');

      return {title: content};
    } else {
      print(response.request.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> _getGroupInfo() async {
    List<String> groupIDS = [
      '2kaVMcxmbsoffpr8fjTC',
      '67RS4ivzkxOlSEl4V6yb',
      'BQIcFGFWXQOCYbPqvgSu',
      'HPpzkzJHJYMNfoYWrVkF',
      'JMW42sjyxThMgexBQdcX',
    ];
    Random rand = Random();
    var randgroupID = groupIDS[rand.nextInt(4)];
    var groupInfo = await firestore.collection('Groups').doc(randgroupID).get();
    return groupInfo.data();
  }

  Future<String> getPosterName(String randUserID) async {
    var doc = await firestore.collection('Users').doc(randUserID).get();
    return doc.data()['username'];
  }

  Future uploadPost(Post post) async {
    await firestore.collection('Posts').add(post.toJSON());
  }

  void populateFollowers() async {
    /**
     * populate users_followers list
     */
    var result = await firestore.collection('Posts').orderBy('username').get();
    var resDocs = result.docs;
    List<String> Faruk223 = List(),
        Ikechukwu56 = List(),
        JohnSnow11 = List(),
        KayodeFish = List(),
        Nabs = List(),
        altintop = List(),
        dvm4lyf = List(),
        jamjoekin3 = List(),
        kelechi112 = List();
    String username;
    for (var item in resDocs) {
      String username = item.data()['username'];
      var groupName = item.data()['group_name'];
    }
    await firestore
        .collection('user_groups')
        .doc('JohnSnow11')
        .set(toArray(JohnSnow11));
  }

  toArray(List<String> list) {
    return {'group_names': list};
  }

  List<String> usernames = List();

  populateComments() async {
    usernames.add('Faruk223');
    usernames.add('Ikechukwu56');
    usernames.add('JohnSnow11');
    usernames.add('KayodeFish');
    usernames.add('Nabs');
    usernames.add('altintop');
    usernames.add('dvm4lyf');
    usernames.add('jamjoekin3');
    usernames.add('kelechi112');
    usernames.add('Lishhs');

    var posts_ = await firestore.collection('Posts').get();
    List<QueryDocumentSnapshot> docs_ = posts_.docs;
    List<String> docsIDS = List();
    for (var item in docs_) {
      docsIDS.add(item.id);
    }

    for (int i = 0; i < 1000; i++) {
      var rand = Random();
      var comment = await generateComment(rand.nextInt(75));
      // print(comment);
      await firestore
          .collection('Posts')
          .doc(docsIDS[rand.nextInt(docsIDS.length - 1)])
          .collection('comments')
          .add(commentJSON(
              rand.nextInt(200),
              usernames[rand.nextInt(usernames.length - 1)],
              Timestamp.fromDate(DateTime.now()),
              comment));
    }
  }

  Map<String, dynamic> commentJSON(
      int likes_count, String username, Timestamp dateposted, String text) {
    return {
      'likes_count': likes_count,
      'username': username,
      'date_posted': dateposted,
      'content': text,
    };
  }

  Future<String> generateComment(int length) async {
    // var tAndC = await _getTitleAndContent();
    Map<String, String> key = {'X-Api-Key': 'a3d5af840b8c49fca6e064342a6518b9'};
    var url = 'https://randommer.io/api/Text/LoremIpsum' +
        '?loremType=normal&type=words&number=$length';
    final response = await http.get(url, headers: key);
    if (response.statusCode == 200) {
      String commentGenerated = json.decode(response.body);
      // print(commentGenerated);
      return commentGenerated;
    } else
      return null;
  }
}
