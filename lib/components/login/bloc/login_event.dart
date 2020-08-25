part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginPressed extends LoginEvent {
  final String username, password;

  LoginPressed({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];
}

class GoogleSignInPressed extends LoginEvent {}
