import 'package:flutter/material.dart';
import 'package:ippon/screens/matchbook.dart';
import 'package:ippon/screens/record-match/record.dart';
import 'package:ippon/screens/record-match/type.dart';
import 'package:ippon/screens/stats.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

List<Widget> _buildScreens() {
  return [
    const Matchbook(),
    const Stats(),
    const SelectKarateMatchType(),
    const Stats(),
    const Stats()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
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
