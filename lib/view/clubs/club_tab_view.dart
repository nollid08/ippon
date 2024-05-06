import 'package:flutter/material.dart';
import 'package:ippon/view/clubs/all_clubs.dart';
import 'package:ippon/view/clubs/modals/add_club.dart';
import 'package:ippon/view/clubs/widgets/add_club_fab.dart';

class ClubTabView extends StatelessWidget {
  const ClubTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Clubs'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'My Clubs'),
                Tab(text: 'All Clubs'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Placeholder(),
              AllClubs(),
            ],
          ),
          floatingActionButton: const AddClubFab(),
        ));
  }
}
