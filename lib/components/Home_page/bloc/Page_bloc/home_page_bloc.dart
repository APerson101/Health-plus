import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:health_plus/components/Home_page/postsRepo.dart';
import 'package:health_plus/models/Post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageLoading());
  final _postsRepository = PostsRepository();

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is FetchPostsEvent) {
      yield HomePageLoading();
      SharedPreferences _preferences;
      if (_preferences == null) {
        _preferences = await SharedPreferences.getInstance();
      }

      var _savedpref = _preferences.getBool('HOME_VIEW');

      if (_savedpref == null || _savedpref) {
        yield* _getPosts(home: _savedpref);
      } else if (_savedpref != null && !_savedpref) {
        yield* _getPosts();
      }
    }

    if (event is SwitchViewEvent) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      bool homeS = event.switchTo == 'home';
      _pref.setBool('HOME_VIEW', homeS);
      // yield HomePageLoading();
    }

    if (event is UserJoinedGroup) {
      //determine if user follows any groups
      var res = await _postsRepository.determineGroups();
      if (res != null)
        yield PostingStatus(true, res);
      else
        return;
    }
  }

  Stream<HomePageState> _getPosts({bool home}) async* {
    if (_postsRepository == null) {
      return;
    }
    try {
      if (home != null && home) {
        List<String> _userGroups = await _postsRepository.getUserGroups();
        if (_userGroups == null) {
          //user hasnt joined groups
          yield NoGroupsJoined();
        } else {
          List<Post> _posts =
              await _postsRepository.getPosts(groups: _userGroups);
          if (_posts != null) {
            //posts exists
            yield PostsLoadSuccess(_posts);
          } else {
            //posts don't exist
            yield NoPostsInGroups();
          }
        }
      } else {
        //getting popular posts
        List<Post> _posts = await _postsRepository.getPosts();
        if (_posts != null) {
          //posts exists
          yield PostsLoadSuccess(_posts);
        } else {
          //posts don't exist

          yield NoPostsInGroups();
        }
      }
    } catch (e) {
      yield PostsLoadFailure();
    }
  }
}
