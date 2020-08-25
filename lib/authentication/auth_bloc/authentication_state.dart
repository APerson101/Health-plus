part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//initialize firebase app, and check if user is signed in else
class Unanthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'unauthenticated yet';
  }
}

class Authenticated extends AuthenticationState {
  @override
  String toString() {
    return 'user has been authenticated';
  }
}
