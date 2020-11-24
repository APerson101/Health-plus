import 'package:equatable/equatable.dart';
import 'package:health_plus/models/Post.dart';
import 'package:meta/meta.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

enum HomeViewState { home, popular }

class HomePageLoading extends HomePageState {}

class PostsLoadSuccess extends HomePageState {
  final List<Post> list;
  PostsLoadSuccess(this.list);
  @override
  List<Object> get props => list;
}

class PostsLoadFailure extends HomePageState {}

class CreateNewPost extends HomePageState {}

class SortedView extends HomePageState {}

class SortedHome extends HomePageState {}

class Schedule extends HomePageState {}

class NoGroupsJoined extends HomePageState {}

class NoPostsInGroups extends HomePageState {}

class PostingStatus extends HomePageState {
  final bool postStatus;
  final List<String> userGroups;

  PostingStatus(this.postStatus, this.userGroups);
}
