import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends HomePageEvent {}

class AddPostsEvent extends HomePageEvent {}

class SwitchViewEvent extends HomePageEvent {
  final String switchTo;
  SwitchViewEvent({@required this.switchTo});
}

class SwitchHomeViewEvent extends HomePageEvent {}

class ScrolltoTopEvent extends HomePageEvent {}

class ScheduleClickEvent extends HomePageEvent {}

class UserJoinedGroup extends HomePageEvent {}
