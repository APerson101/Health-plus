import 'dart:async';

import 'package:bloc/bloc.dart';
import 'tabs.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsState.HomePageTab);

  @override
  Stream<TabsState> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is TabSelected) {
      //If user seletected the home button again, then scroll to top
      // if (event.selectedTab == state) {
      //   _scrollToTop();
      // }
      yield event.selectedTab;
    }
  }
}
