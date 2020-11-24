import 'package:equatable/equatable.dart';

import '../comment.dart';

abstract class PostdetailsState extends Equatable {
  const PostdetailsState();

  @override
  List<Object> get props => [];
}

class PostdetailsInitial extends PostdetailsState {}

class EventSuccessful extends PostdetailsState {}

class EventFailure extends PostdetailsState {}

class EventLoading extends PostdetailsState {}

class CommentsLoadSuccess extends PostdetailsState {
  final List<Comment> comments;

  CommentsLoadSuccess(this.comments);
}
