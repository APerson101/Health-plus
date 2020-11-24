import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'tabs.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();

  @override
  List<Object> get props => [];
}

class TabSelected extends TabsEvent {
  final TabsState selectedTab;

  TabSelected({@required this.selectedTab});
}
