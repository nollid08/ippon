import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ippon/model/clubs/club.dart';
import 'package:ippon/model/clubs/club_types.dart';
import 'package:ippon/view/clubs/modals/add_club.dart';
import 'package:ippon/view/clubs/widgets/all_clubs_list_view.dart';

class AllClubs extends StatelessWidget {
  const AllClubs({super.key});

  @override
  Widget build(BuildContext context) {
    return const AllClubsListView();
  }
}
