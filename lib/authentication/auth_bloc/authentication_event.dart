part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class LoggedInSuccess extends AuthenticationEvent {}

class AuthenticationInitial extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
