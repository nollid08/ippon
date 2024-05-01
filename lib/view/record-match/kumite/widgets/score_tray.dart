import 'package:flutter/material.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';

class ScoreTray extends StatelessWidget {
  const ScoreTray({
    super.key,
    required this.match,
  });

  final KumiteMatch? match;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text('Me: ${match!.homeScore}'),
          ],
        ),
        Column(
          children: [
            Text('${match!.opponent}: ${match!.awayScore}'),
          ],
        ),
      ],
    );
  }
}
