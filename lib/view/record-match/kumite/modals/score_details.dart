import 'package:flutter/material.dart';
import 'package:ippon/model/karate/kumite/score.dart';
import 'package:ippon/model/karate/kumite/techniques.dart';

class ScoreDetails extends StatelessWidget {
  const ScoreDetails({
    super.key,
    required this.score,
    required this.opponent,
  });

  final Score score;
  final String opponent;

  @override
  Widget build(BuildContext context) {
    final String technique = score.technique.data.japaneseName;
    final String target = score.target.name;
    final String scoreType = score.type.name;
    final String description = score.description ?? 'No description';
    final String scoredBy = score.homeScored ? 'Me' : opponent;
    final String scoredAgainst = score.homeScored ? opponent : 'Me';
    return AlertDialog(
      title: const Text('Score Details'),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Technique: $technique'),
            Text('Target: $target'),
            Text('Type: $scoreType'),
            Text('Description: $description'),
            Text('Scored by: $scoredBy'),
            Text('Scored against: $scoredAgainst'),
          ]),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
