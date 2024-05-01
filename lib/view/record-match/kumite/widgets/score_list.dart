import 'package:flutter/material.dart';
import 'package:ippon/model/karate/kumite/kumite_match.dart';
import 'package:ippon/model/karate/kumite/score.dart';
import 'package:ippon/view/record-match/kumite/widgets/score_tile.dart';

class ScoreList extends StatelessWidget {
  const ScoreList({
    super.key,
    required this.match,
    this.onDelete,
    this.onReorder,
    this.onTap,
  });

  final KumiteMatch match;
  final void Function(int oldIndex, int newIndex)? onReorder;
  final void Function(Score)? onDelete;
  final void Function(Score)? onTap;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = match.scores.map<Widget>((Score score) {
      return ScoreTile(
        match: match,
        score: score,
        onTap: onTap,
        onDelete: onDelete,
        key: Key(
          match.scores.indexOf(score).toString(),
        ),
      );
    }).toList();
    if (onReorder != null && match.scores.length > 1) {
      return ReorderableListView(
        shrinkWrap: true,
        onReorder: onReorder!,
        children: children,
      );
    } else {
      return ListView(
        shrinkWrap: true,
        children: children,
      );
    }
  }
}
