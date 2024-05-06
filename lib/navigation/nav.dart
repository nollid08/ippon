import 'package:flutter/material.dart';
import 'package:ippon/view/clubs/all_clubs.dart';
import 'package:ippon/view/clubs/club_tab_view.dart';
import 'package:ippon/view/matchbook.dart';
import 'package:ippon/view/record-match/kumite/record.dart';
import 'package:ippon/view/record-match/type.dart';
import 'package:ippon/view/stats.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

void jumpToTab(int index) {
  _controller.jumpToTab(index);
}

List<Widget> _buildScreens() {
  return [
    const Matchbook(),
    const Stats(),
    const SelectKarateMatchType(),
    const ClubTabView(),
    const Stats()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/matchbook',
        routes: {
          '/matchbook': (context) => const Matchbook(),
        },
      ),
      icon: const Icon(
        Icons.book_outlined,
      ),
      title: ("Match Book"),
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: Colors.blueGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.insights_outlined,
      ),
      title: ("Stats"),
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: Colors.blueGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      routeAndNavigatorSettings: RouteAndNavigatorSettings(
        initialRoute: '/record',
        routes: {
          '/record': (context) => const SelectKarateMatchType(),
        },
      ),
      title: ("Record"),
      activeColorPrimary: Colors.green,
      inactiveIcon: const Icon(
        Icons.add,
        color: Color.fromARGB(255, 54, 65, 55),
      ),
      inactiveColorPrimary: Colors.blueGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.groups_outlined,
      ),
      title: ("Clubs"),
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: Colors.blueGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.face_outlined,
      ),
      title: ("Profile"),
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: Colors.blueGrey,
    ),
  ];
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      floatingActionButton: SizedBox.shrink(),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
