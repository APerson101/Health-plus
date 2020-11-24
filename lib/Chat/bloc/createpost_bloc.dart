import 'dart:async';

import 'package:bloc/bloc.dart';

import '../create_repo.dart';
import 'createpost.dart';

class CreatePostBloc extends Bloc<CreatepostEvent, CreatepostState> {
  CreatePostBloc() : super(CreatepostInitial());
  CreatePostRepo _repo = CreatePostRepo();
  @override
  Stream<CreatepostState> mapEventToState(
    CreatepostEvent event,
  ) async* {
    if (event is StartEvent) {
      print('strting');
      if (_repo != null) {
        List<String> groups = await _repo.fetchgroups();
        print('groups fetched: ' + groups.toString());
        yield GroupFetchSuccess(groups);
      }
    }

    if (event is SavePostEvent) {
      try {
        await _repo.savePost(event);
        yield SaveSuccess();
      } catch (e) {
        throw UnimplementedError();
      }
    }
  }
}
