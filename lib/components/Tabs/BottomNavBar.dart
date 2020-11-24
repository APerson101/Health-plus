import 'package:flutter/material.dart';

import 'bloc/tabs.dart';

class BottomNavBar extends StatelessWidget {
  final Function(TabsState) selector;
  final TabsState activeTab;

  const BottomNavBar({Key key, this.selector, this.activeTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) => selector(TabsState.values[index]),
        items: TabsState.values.map((_tab) {
          IconData icon;
          if (_tab == TabsState.HomePageTab) icon = Icons.home;
          if (_tab == TabsState.NotificationsTab) icon = Icons.chat;
          if (_tab == TabsState.SearchPageTab) icon = Icons.search;
          if (_tab == TabsState.ProfilePageTab) icon = Icons.person;
          return navItemCreator(icon);
        }).toList(),
        currentIndex: TabsState.values.indexOf(activeTab),
        type: BottomNavigationBarType.fixed);
  }

  BottomNavigationBarItem navItemCreator(IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(''),
        activeIcon: Icon(
          icon,
          color: Colors.red,
        ));
  }
}
