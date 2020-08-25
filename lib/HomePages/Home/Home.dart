import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/authentication/auth_bloc/authentication_bloc.dart';
import 'package:health_plus/authentication/authentication_repo.dart';
import 'suggestions.dart';

class Home extends StatefulWidget {
  String text;
  Home(this.text);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String buttonSelectedValue;

  @override
  void initState() {
    super.initState();
    buttonSelectedValue = 'Popular';
  }

  bool subscriptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: SafeArea(
        child: Container(
            color: buttonSelectedValue == 'Home' ? Colors.red : Colors.blue,
            child: buildContainer()),
      ),
    );
  }

  Widget buildContainer() {
    return Column(
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              color: Colors.green,
              onPressed: () async {
                final auth = Authentication_Repo();
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                await auth.signOut();
              },
              child: Text('signOut'),
            ),
            RaisedButton(
              color: Colors.red,
              onPressed: () async {
                final auth = Authentication_Repo();
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                await auth.delete();
              },
              child: Text('Delete Acount'),
            )
          ],
        )
      ],
    );
  }

// if (buttonSelectedValue == 'Home') {
//       if (!subscriptions) {
//          SuggestionsPage(),
//       } else
//          Text('youre home'),
//     }
//      else Text('youre popular'),

  Widget homeAppBar() {
    const menuItems = <String>['Home', 'Popular'];
    final List<DropdownMenuItem<String>> dropMenu = menuItems
        .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ))
        .toList();
    return AppBar(
      title: DropdownButton(
          items: dropMenu,
          value: buttonSelectedValue,
          onChanged: (String value) {
            setState(() {
              buttonSelectedValue = value;
            });
          }),
    );
  }
}
