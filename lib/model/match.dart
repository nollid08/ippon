import 'package:ippon/model/result.dart';
import 'package:ippon/model/scoring_system.dart';
import 'package:ippon/model/targets.dart';
import 'package:ippon/model/techniques.dart';

import 'score.dart';

class Match {
  final String title;
  final String description;
  final String opponent;
  final DateTime dateTime;
  final ScoringSystems scoringSystem;
  final String type;
  Result _result;
  int _homeScore;
  int _awayScore;
  List<Score> _scores;

  Match({
    required this.title,
    required this.description,
    required this.opponent,
    required this.dateTime,
    required this.scoringSystem,
    this.type = 'kumite',
    List<Score> scores = const [],
  })  : _awayScore = 0,
        _homeScore = 0,
        _result = Result.draw,
        _scores = scores {
    _updateMatchStats();
  }

  get result => _result;
  get homeScore => _homeScore;
  get awayScore => _awayScore;
  get scores => _scores;

  void addScore(Score score) {
    //add score to _scores which is immutable
    print(_scores.length);
    _scores = [..._scores, score];
    print(_scores.length);
    _updateMatchStats();
  }

  void removeScore(Score score) {
    _scores.remove(score);
    _updateMatchStats();
  }

  void updateScore(Score oldScore, Score newScore) {
    final index = _scores.indexOf(oldScore);
    _scores[index] = newScore;
    _updateMatchStats();
  }

  void _updateMatchStats() {
    final homeScoresMap = _scores
        .where((score) => score.homeScored)
        .map((score) => score.type.value);
    _homeScore = homeScoresMap.isEmpty
        ? 0
        : homeScoresMap.reduce((value, element) => value + element);
    _awayScore = _awayScoreCount(_scores);

    if (_homeScore > _awayScore) {
      _result = Result.win;
    } else if (_homeScore < _awayScore) {
      _result = Result.loss;
    } else {
      _result = Result.draw;
    }
  }

  int _homeScoreCount(List<Score> scores) {
    final homeScoresMap = scores
        .where((score) => score.homeScored)
        .map((score) => score.type.value);
    final int homeScore = homeScoresMap.isEmpty
        ? 0
        : homeScoresMap.reduce((value, element) => value + element);
    return homeScore;
  }

  int _awayScoreCount(List<Score> scores) {
    final awayScoresMap = scores
        .where((score) => !score.homeScored)
        .map((score) => score.type.value);
    final int awayScore = awayScoresMap.isEmpty
        ? 0
        : awayScoresMap.reduce((value, element) => value + element);
    return awayScore;
  }
}
