import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_plus/authentication/auth_bloc/authentication_bloc.dart';
import 'package:health_plus/authentication/authentication_repo.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authbloc;
  LoginBloc({@required this.authbloc})
      : assert(authbloc != null),
        super(LoginInitial());
  final auth = Authentication_Repo();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginPressed) {
      //show loading while validating
      print('Login pressed');
      // yield LoginInProgress();
      try {
        await auth.signInWithEmailPassword(
            email: event.username, password: event.password);

        authbloc.add(LoggedInSuccess());
        // yield LoginInitial();
      } on Exception {
        LoginFailure(errorMessage: 'Error, try again').printer();
      }
    } else if (event is GoogleSignInPressed) {
      try {
        await auth.signInWithGoogle();
        authbloc.add(LoggedInSuccess());
      } on Exception {
        LoginFailure(errorMessage: 'Error, try again').printer();
      }
    }
  }
}
