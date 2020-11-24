import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/authentication/auth_bloc/authentication_bloc.dart';
import 'package:health_plus/components/routes.dart';
import 'Chat/addMessage.dart';
import 'components/PostDetails/DisplayPosts.dart';
import 'components/login/LoginForm.dart';
import 'mainApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider<AuthenticationBloc>(
            create: (_) {
              final auth = AuthenticationBloc();
              auth.add(AuthenticationInitial());
              return auth;
            },
            child: MyHomePage(),
          );
        }
        return MaterialApp(
          home: Text('error'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/postDetails': (context) => PostDetails(),
        routeNames.splashscreen: (context) => SplashScreen(),
        '/GroupChat': (context) => GroupPost(),
      },
      navigatorKey: _navigatorKey,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Unanthenticated) {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => LoginForm()),
              //     (route) => false);
              _navigator.pushAndRemoveUntil<void>(
                LoginForm.route(),
                (route) => false,
              );
            } else if (state is Authenticated) {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => MainApp()),
              //     (route) => false);
              _navigator.pushAndRemoveUntil<void>(
                MainApp.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      // onGenerateRoute: RouteNavigation.generatorRoute,
      initialRoute: routeNames.splashscreen,
      // onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  // SplashScreen();
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.jpg',
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      ),
    );
  }
}
