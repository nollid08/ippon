import 'package:ippon/model/scoring_system.dart';
import 'package:ippon/model/targets.dart';
import 'package:ippon/model/techniques.dart';

class Score {
  final int index;
  final ScoreType type;
  final Techniques technique;
  final Targets target;
  final String description;
  final bool homeScored;

  Score({
    required this.index,
    required this.homeScored,
    required this.type,
    required this.technique,
    required this.target,
    required this.description,
  });
}
