import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../authentication_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final auth = Authentication_Repo();
  AuthenticationBloc() : super(Unanthenticated());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LoggedInSuccess) {
      // await auth.IntializeFireBase();
      print(Authenticated().toString());
      // print(auth.user.toString());
      yield Authenticated();
    }

    if (event is AuthenticationInitial) {
      //try and get from repo and return appropriately
      if (auth.CurrentUser == null) {
        yield Unanthenticated();
        print(Unanthenticated().toString());
      } else {
        print(Authenticated().toString());
        print(auth.CurrentUser.toString());
        yield Authenticated();
      }
    }

    if (event is LoggedOut) {
      yield Unanthenticated();
    }
  }
}
