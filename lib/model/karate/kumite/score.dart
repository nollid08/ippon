import 'package:ippon/model/karate/kumite/scoring_system.dart';
import 'package:ippon/model/karate/kumite/targets.dart';
import 'package:ippon/model/karate/kumite/techniques.dart';

class Score {
  final ScoreType type;
  final Techniques technique;
  final Targets target;
  final String? description;
  final bool homeScored;

  Score({
    required this.homeScored,
    required this.type,
    required this.technique,
    required this.target,
    required this.description,
  });
}
