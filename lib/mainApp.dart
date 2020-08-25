import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/HomePages/search.dart';
import 'package:health_plus/HomePages/socialMedia.dart';

import 'HomePages/Home/Home.dart';
import 'HomePages/Profile/profile.dart';

class MainApp extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MainApp());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseApp(),
    );
  }
}

class BaseApp extends StatefulWidget {
  BaseApp();
  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  int currentPage = 0;
  List<Widget> pages = [];
  List<Widget> appBars = [];
  bool _showClearButton = false;

  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    pages.add(Home("HOME"));
    // pages.add(SocialMedia("SOCIAL MEDIA"));
    pages.add(Search("SEARCH"));
    pages.add(Profile("PROFILE"));

    // appBars.add(homeAppBar());
    appBars.add(chatAppBar());
    appBars.add(searchAppBar());
    appBars.add(profileAppBar());

    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.length > 0;
      });
    });

    //check if the user follows Groups yet
//Still need to add appBars
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Future getPosts() async {
  //   var post = await Firestore.instance
  //       .collection('Posts')
  //       .where('group_name', whereIn: ['HIV', 'cancer'])
  //       .getDocuments()
  //       .then((value) {
  //         value.documents.forEach((element) {
  //           print(element['Title']);
  //         });
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    // getPosts();
    final header = UserAccountsDrawerHeader(
        accountName: Text('first Last'), accountEmail: Text('name@gmail.com'));
    final profileDrawer = ListView(
      children: <Widget>[
        header,
        ListTile(
          title: Text('Saved Items'),
          onTap: () => Navigator.pushNamed(context, '/savedItems'),
        ),
        ListTile(
          title: Text('Add smart Device'),
          onTap: () => Navigator.pushNamed(context, '/addDevice'),
        ),
        ListTile(
          title: Text('Medical Professional'),
          onTap: () => Navigator.pushNamed(context, '/medicalProfessional'),
        ),
        ListTile(
          title: OutlineButton(
              child: Text('SIGN OUT'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Confirm Sign Out"),
                    content: Text("you sure about that?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel')),
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            print('Sign out pressed');
                          },
                          child: Text('Sign out')),
                    ],
                  ),
                );
              }),
        )
      ],
    );
    return Scaffold(
      // appBar: appBars[currentPage],
      body: Container(child: pages[currentPage]),
      bottomNavigationBar: btmNav(),
    );
    // drawer: (() {
    //   if (currentPage == 3) {
    //     return Drawer(
    //       child: profileDrawer,
    //     );
    //   }
    //   return null;
    // }()));
  }

  Widget btmNav() {
    return BottomNavigationBar(
        onTap: _tabTapped,
        items: [
          navItemCreator(Icons.home),
          navItemCreator(Icons.chat),
          navItemCreator(Icons.search),
          navItemCreator(Icons.person)
        ],
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed);
  }

  BottomNavigationBarItem navItemCreator(IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(''),
        activeIcon: Icon(
          icon,
          color: Colors.red,
        ));
  }

  _tabTapped(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Widget searchAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(children: <Widget>[
        Expanded(
            child: TextField(
          controller: _controller,
          onSubmitted: (value) async {
            await search(value);
          },
          onChanged: (text) {
            setState(() {
              print(text);
            });
          },
          decoration:
              InputDecoration(hintText: 'Search', suffixIcon: getIcon()),
        ))
      ]),
    );
  }

  search(String value) {
    //Search for what was entered
    print("Searching for " + value);
  }

  getIcon() {
    if (!_showClearButton) {
      return null;
    }
    return IconButton(
      onPressed: () => _controller.clear(),
      icon: Icon(Icons.clear),
    );
  }

  Widget chatAppBar() {
    return AppBar(
      title: Text("Groups"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.chat_bubble), onPressed: newChat),
        IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Future.delayed(Duration.zero, () {
                newGroup(context);
              });
            }), //newGroup(context)),
        IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              Future.delayed(Duration.zero, () {
                sort(context);
              });
            })
      ],
    );
  }

  void newChat() {
    Navigator.pushNamed(context, '/GroupChat');
  }

  void newGroup(BuildContext context_) {
    //Show modal bottom sheet
    showModalBottomSheet(
        context: context_, builder: (context_) => buildbtmSheet(context_));
    // Navigator.pushNamed(context, '/JoinGroup');
  }

  void sort(BuildContext context_) {
    //Bring up pop up menu
    showModalBottomSheet(
        context: context_,
        builder: (context_) => buildSortBottomSheet(context_));
  }

  buildSortBottomSheet(BuildContext context) {
    const menuItems = <String>[
      'Group 1',
      'Group 2',
      'Group 3',
      'Group 4',
      'Group 5',
      'Group 6'
    ];
    final List<DropdownMenuItem<String>> dropMenu = menuItems
        .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ))
        .toList();
    String buttonSelectedValue;
    return Container(
        height: 200,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            OutlineButton(child: Text("Sort"), onPressed: null),
            Row(
              children: <Widget>[
                DropdownButton(
                  value: buttonSelectedValue,
                  hint: Text("Choose Group"),
                  items: dropMenu,
                  onChanged: (String value) {
                    setState(() {
                      buttonSelectedValue = value;
                    });
                  },
                ),
                DropdownButton(
                  value: buttonSelectedValue,
                  hint: Text("Order by"),
                  items: dropMenu,
                  onChanged: (String value) {
                    setState(() {
                      buttonSelectedValue = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }

  buildbtmSheet(BuildContext context_) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            child: Center(
              child: OutlineButton(child: Text("Join"), onPressed: null),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context_, i) {
                    return ListTile(
                      leading: Switch(value: true, onChanged: null),
                      title: Text('This Group'),
                    );
                  }))
        ],
      ),
    );
  }

  profileAppBar() {
    return AppBar(
      title: Text("Profile"),
    );
  }
}
