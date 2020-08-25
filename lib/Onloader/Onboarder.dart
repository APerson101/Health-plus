import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  IntroPage();
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(children: <Widget>[
        Container(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () => _pageController.animateToPage(2,
                  duration: Duration(milliseconds: 500), curve: Curves.ease),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            )),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: <Widget>[pic1(), pic2(), pic3()],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
        _currentPage != 3 - 1
            ? Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Text(''),
      ]),
      bottomSheet: _currentPage == 3 - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: itemtapped,
                // new MaterialPageRoute(builder: (context) => MainApp())),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }

  itemtapped() {
    Navigator.pushReplacementNamed(context, '/mainApp');
  }
}

Widget pic1() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      image:
          DecorationImage(image: AssetImage('assets/images/onboarding2.jpg')),
    ),
  );
}

Widget pic2() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      image:
          DecorationImage(image: AssetImage('assets/images/onboarding1.jpg')),
    ),
  );
}

Widget pic3() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      image:
          DecorationImage(image: AssetImage('assets/images/onboarding3.jpg')),
    ),
  );
}
