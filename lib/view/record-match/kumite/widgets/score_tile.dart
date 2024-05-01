import 'package:flutter/material.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';
import 'package:ippon/model/karate/kumite/score.dart';
import 'package:ippon/model/karate/kumite/targets.dart';
import 'package:ippon/model/karate/kumite/techniques.dart';

class ScoreTile extends StatelessWidget {
  final KumiteMatch match;
  final Score score;
  final void Function(Score)? onTap;
  final void Function(Score)? onDelete;

  const ScoreTile({
    super.key,
    required this.match,
    required this.score,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String scoreType = score.type.name;
    final Techniques technique = score.technique;
    final String techniqueName = technique.data.japaneseName;
    final Targets target = score.target;
    final String targetName = target.info.japaneseName;
    final int value = score.type.value;
    final bool homeScored = score.homeScored;
    final String opponent = match.opponent;

    return Card(
      color: homeScored ? Colors.green[50] : Colors.red[50],
      child: ListTile(
        onTap: onTap != null ? () => onTap!(score) : null,
        leading: Text(
          "$value point${(value > 1) ? 's' : ''}",
          style: const TextStyle(fontSize: 15.0),
        ),
        title: Text('$scoreType - $techniqueName $targetName'),
        subtitle:
            Text(score.homeScored ? 'Scored by me' : 'Scored by $opponent'),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDelete!(score);
                },
              )
            : null,
      ),
    );
  }
}
