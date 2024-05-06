import 'package:flutter/material.dart';
import 'package:ippon/view/clubs/modals/add_club.dart';

class AddClubFab extends StatelessWidget {
  const AddClubFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AddClub();
          },
        );
      },
      label: Text("Create A Club"),
      icon: const Icon(Icons.create),
    );
  }
}
