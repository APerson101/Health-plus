import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppBarEvent {}

class InitialAppBarEvent extends AppBarEvent {}

class ChangedAppBarEvent extends AppBarEvent {}

abstract class AppBarState {
  String status;

  AppBarState(this.status);
}

class HomeAppBarState extends AppBarState {
  HomeAppBarState(String status) : super(status);
}

class HomeAppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  HomeAppBarBloc() : super(HomeAppBarState('home'));

  @override
  Stream<AppBarState> mapEventToState(AppBarEvent event) async* {
    if (event is InitialAppBarEvent) {
      SharedPreferences _preferences;
      if (_preferences == null) {
        _preferences = await SharedPreferences.getInstance();
        var _savedpref = _preferences.getBool('HOME_VIEW');
        yield _savedpref ? HomeAppBarState('home') : HomeAppBarState('popular');
      }
    }

    if (event is ChangedAppBarEvent) {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      state.status == 'home' ? state.status = 'popular' : state.status = 'home';

      bool homeS = state.status == 'home' ? true : false;

      _pref.setBool('HOME_VIEW', homeS);
    }
  }
}
