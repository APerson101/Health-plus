import 'package:equatable/equatable.dart';

abstract class CreatepostState extends Equatable {
  const CreatepostState();

  @override
  List<Object> get props => [];
}

class CreatepostInitial extends CreatepostState {
  bool canCreateGroup;
}

class GroupFetchSuccess extends CreatepostState {
  final List<String> groups;

  GroupFetchSuccess(this.groups);
}

class SaveSuccess extends CreatepostState {}

class SaveFailure extends CreatepostState {}
