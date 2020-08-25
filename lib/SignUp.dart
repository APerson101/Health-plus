import 'package:flutter/material.dart';
import 'package:health_plus/Onloader/Onboarder.dart';

import 'SignUpPages/MedicalHistory.dart';
import 'SignUpPages/MedicalProfessional.dart';
import 'SignUpPages/SyncDevice.dart';

class SignUp extends StatelessWidget {
  const SignUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeNavigator(),
    );
  }
}

class HomeNavigator extends StatefulWidget {
  HomeNavigator();
  @override
  _HomeNavigatorState createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  var text = "Skip";
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) => currentPage = value,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            MedicalHistory(),
            Device(),
            Professional(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OutlineButton(child: Text(text), onPressed: changeText),
            OutlineButton(
              onPressed: nextPage,
              child: Text("next"),
            )
          ],
        ),
      ),
    ));
  }

  void nextPage() {
    setState(() {
      if (currentPage != 2) {
        text = "back";
        _pageController.animateToPage(currentPage + 1,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      } else if (currentPage == 2) {
        //Next page
        // Navigator.pushNamed(context, '/introPage');
        // Navigator.push(
        //     context, new MaterialPageRoute(builder: (context) => IntroPage()));
        Navigator.pushReplacementNamed(context, '/introPage');
      }
    });
  }

  void changeText() {
    if (currentPage != 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      if (currentPage == 1) {
        setState(() {
          text = "Skip";
        });
      }
    } else {
      //skip
      print("skip pressed");
    }
  }
}
