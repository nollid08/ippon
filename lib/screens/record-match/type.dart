import 'package:flutter/material.dart';
import 'package:ippon/screens/record-match/kumite/create.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SelectKarateMatchType extends StatelessWidget {
  const SelectKarateMatchType({super.key});

  @override
  Widget build(BuildContext context) {
    //Return a scaffold with an appbar and 2 buttons- one for kata, one for kumite
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Match Type'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity, height: 0),
          SquareElevatedButton(
            onPressed: () {},
            title: 'Kata',
            icon: Icons.accessibility_new,
          ),
          SquareElevatedButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: CreateKumiteMatch(),
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            title: 'Kumite',
            icon: Icons.sports_martial_arts,
          ),
        ],
      ),
    );
  }
}

class SquareElevatedButton extends StatelessWidget {
  const SquareElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
  });
  final Function onPressed;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 200),
      ),
      onPressed: () {
        onPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 80), // Large icon
          Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
