import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:equatable/equatable.dart';

abstract class CreatepostEvent extends Equatable {
  const CreatepostEvent();

  @override
  List<Object> get props => [];
}

class StartEvent extends CreatepostEvent {}

class SavePostEvent extends CreatepostEvent {
  Timestamp timestamp;
  String content, groupname, title;
  int commentsCount, likesCount;

  SavePostEvent(this.timestamp, this.content, this.groupname, this.title,
      this.commentsCount, this.likesCount);
}
