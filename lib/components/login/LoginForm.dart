import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/authentication/auth_bloc/authentication_bloc.dart';
import 'package:health_plus/components/login/bloc/login_bloc.dart';
import 'package:health_plus/layout/imageLoader.dart';

class LoginForm extends StatefulWidget {
  // final AuthenticationBloc auth;

  // const LoginForm(AuthenticationBloc bloc, {Key key, this.auth})
  //     : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => LoginForm(),
    );
  }

  @override
  _LoginFormState createState() => _LoginFormState();
}

TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            LoginBloc(authbloc: BlocProvider.of<AuthenticationBloc>(context)),
        child: Form(
          key: _formKey,
          child: Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                HealthLogo(),
                SizedBox(
                  height: 40,
                ),
                usernameTextField(),
                SizedBox(
                  height: 20,
                ),
                passwordTextField(),
                LoginButton(
                  formKey: _formKey,
                ),
                SizedBox(height: 20),
                SocialMediaSignUp(),
              ],
            )),
          ),
        ));

    // FormWidgets());
  }

  Widget usernameTextField() {
    return Container(
      child: TextFormField(
        validator: (value) => detailsValidator(value, 'Username'),
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: "Username",
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Container(
      child: TextFormField(
        validator: (value) => detailsValidator(value, 'Password'),
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
        ),
      ),
    );
  }
}

class HealthLogo extends StatelessWidget {
  const HealthLogo();
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Column(
        children: [
          FadeInImagePlaceholder(
            image: const AssetImage('assets/images/logo.jpg'),
            placeholder: Container(
              width: 34,
              height: 34,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

String detailsValidator(String value, String type) {
  return value.length < 7 ? 'invalid ' + type : null;
}

class SocialMediaSignUp extends StatelessWidget {
  const SocialMediaSignUp();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(child: Divider()),
                Text(
                  'Login with',
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Divider())
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    onPressed: () async {
                      context.bloc<LoginBloc>().add(GoogleSignInPressed());
                    },
                    child: Text('G+')),
                FlatButton(onPressed: null, child: Text('f')),
                FlatButton(onPressed: null, child: Text('Tw'))
              ],
            )
          ],
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({@required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  "LOGIN",
                ),
              ),
              elevation: 8,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              onPressed: () {
                //login the user with credentials Entered
                if (formKey.currentState.validate()) {
                  print('text validated');
                  context.bloc<LoginBloc>().add(LoginPressed(
                      username: _usernameController.text,
                      password: _passwordController.text));
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
