import 'package:flutter/material.dart';
import 'package:health_plus/components/login/LoginForm.dart';

import '../mainApp.dart';

class RouteNavigation {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeNames.login:
        return MaterialPageRoute(builder: (_) => LoginForm());
        break;
      case routeNames.mainApp:
        return MaterialPageRoute(builder: (_) => MainApp());
        break;
      case '/splashScreen':
        return MaterialPageRoute(builder: (_) => MainApp());
        break;
      // case '/postDetails':
      //   return Navigator.pushNamed(context, routeName);
      default:
        return null;
    }
  }
}

class routeNames {
  static const String login = '/login';
  static const String mainApp = '/mainApp';
  static const String splashscreen = '/splashScreen';
}
