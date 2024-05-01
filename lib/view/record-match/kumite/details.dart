import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ippon/model/karate/kumite/score.dart';
import 'package:ippon/model/karate/kumite/scoring_system.dart';
import 'package:ippon/model/karate/kumite/targets.dart';
import 'package:ippon/model/karate/kumite/techniques.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';
import 'package:ippon/navigation/nav.dart';
import 'package:ippon/view/match.dart';
import 'package:ippon/view/record-match/kumite/modals/add_score.dart';
import 'package:ippon/view/record-match/kumite/modals/score_details.dart';
import 'package:ippon/view/record-match/kumite/widgets/score_list.dart';
import 'package:ippon/view/record-match/kumite/widgets/score_tile.dart';
import 'package:ippon/view/record-match/kumite/widgets/score_tray.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DetailKumiteMatch extends StatefulWidget {
  const DetailKumiteMatch({
    super.key,
    required this.match,
  });

  final KumiteMatch match;
  @override
  State<DetailKumiteMatch> createState() => _DetailKumiteMatchState();
}

class _DetailKumiteMatchState extends State<DetailKumiteMatch> {
  KumiteMatch match = KumiteMatch(
    title: 'Default',
    description: 'Default',
    opponent: 'Default',
    dateTime: DateTime.now(),
    scoringSystem: ScoringSystems.IJKA,
  );
  bool completed = false;

  @override
  void initState() {
    super.initState();
    match = widget.match;
  }

  @override
  Widget build(BuildContext context) {
    final scoresToWin = match.scoringSystem.system.scoresToWin;

    if (match.homeScore >= scoresToWin || match.awayScore >= scoresToWin) {
      completed = true;
    } else {
      completed = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(match.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            ScoreList(
              match: match,
              onTap: (Score score) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    //Show dialog with full score details
                    return ScoreDetails(
                      score: score,
                      opponent: match.opponent,
                    );
                  },
                );
              },
              onDelete: (Score score) {
                setState(() {
                  match.removeScore(score);
                });
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  final Score score = match.scores.removeAt(oldIndex);
                  if (newIndex > oldIndex) {
                    match.scores.insert(newIndex - 1, score);
                  } else {
                    match.scores.insert(newIndex, score);
                  }
                });
              },
            ),
            Expanded(
              child: Container(),
            ),
            ScoreTray(
              match: match,
            )
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        // FilledButton.icon(
        //     onPressed: completed
        //         ? null
        //         : () {
        //             showDialog(
        //               context: context,
        //               builder: (BuildContext context) {
        //                 return AddScore(
        //                   match: match,
        //                   onSubmit: (Score score) {
        //                     setState(() {
        //                       match.addScore(score);
        //                     });
        //                     Navigator.of(context).pop();
        //                   },
        //                 );
        //               },
        //             );
        //           },
        //     icon: const Icon(Icons.add),
        //     label: const Text('Add Score')),
        FilledButton.icon(
            onPressed: () async {
              bool isConfirmed = false;
              await showDialog(
                context: context,
                useRootNavigator: true,
                builder: (BuildContext context) {
                  return ConfirmAddMatch(
                    onConfirm: () async {
                      await match.record();
                      var currentContext = context;
                      await Future.delayed(Duration.zero, () {
                        Navigator.of(currentContext).pop();
                      });
                      isConfirmed = true;
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
              if (isConfirmed) {
                jumpToTab(0);
                Future.delayed(Duration.zero, () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Save Match')),
        FilledButton.icon(
            onPressed: () => {
                  Navigator.of(
                    context,
                  ).pop()
                },
            icon: const Icon(Icons.save),
            label: const Text('Save Match'))
      ],
    );
  }
}

class ConfirmAddMatch extends StatelessWidget {
  const ConfirmAddMatch({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  final void Function() onConfirm;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to save this match?'),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
