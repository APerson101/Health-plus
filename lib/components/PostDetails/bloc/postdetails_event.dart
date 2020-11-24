import 'package:equatable/equatable.dart';
import 'package:health_plus/models/Post.dart';

abstract class PostdetailsEvent extends Equatable {
  const PostdetailsEvent();

  @override
  List<Object> get props => [];
}

class SendComment extends PostdetailsEvent {
  final String comment;
  final Post post;

  SendComment(this.comment, this.post);
}

class LoadComments extends PostdetailsEvent {
  final Post post;

  LoadComments(this.post);
}

class ToggleLikeComment extends PostdetailsEvent {
  final String key;
  ToggleLikeComment(this.key);
}

class ToggleLikePost extends PostdetailsEvent {
  Post post;
  ToggleLikePost(this.post);
}
