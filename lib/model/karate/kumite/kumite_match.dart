import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ippon/model/result.dart';
import 'package:ippon/model/karate/kumite/scoring_system.dart';
import 'package:ippon/model/karate/kumite/targets.dart';
import 'package:ippon/model/karate/kumite/techniques.dart';

import 'score.dart';

class KumiteMatch {
  final String title;
  final String? description;
  final String opponent;
  final DateTime dateTime;
  final ScoringSystems scoringSystem;
  Result _result;
  int _homeScore;
  int _awayScore;
  List<Score> _scores;

  KumiteMatch({
    required this.title,
    required this.description,
    required this.opponent,
    required this.dateTime,
    required this.scoringSystem,
    List<Score> scores = const [],
  })  : _awayScore = 0,
        _homeScore = 0,
        _result = Result.draw,
        _scores = scores {
    _updateMatchStats();
  }

  Result get result => _result;
  int get homeScore => _homeScore;
  int get awayScore => _awayScore;
  List<Score> get scores => _scores;

  void addScore(Score score) {
    _scores = [..._scores, score];
    _updateMatchStats();
  }

  void removeScore(Score score) {
    _scores = _scores.where((s) => s != score).toList();
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

  Future<bool> record() async {
    if (scores.isEmpty) {
      return false;
    }

    final db = FirebaseFirestore.instance;
    final batch = db.batch();
    final DocumentReference<Map<String, dynamic>> matchDoc = db
        .collection('users')
        .doc('gBONifqYDpc0fUlRrEE025mJ92m1')
        .collection('matches')
        .doc();

    final Map<String, dynamic> matchData = {
      'type': 'kumite',
      'title': title,
      'description': description,
      'opponent': opponent,
      'dateTime': dateTime,
      'scoringSystem': scoringSystem.system.title,
      'homeScore': homeScore,
      'awayScore': awayScore,
      'result': result.toString(),
    };

    batch.set(matchDoc, matchData);

    for (Score score in scores) {
      final DocumentReference<Map<String, dynamic>> scoreDoc =
          matchDoc.collection('scores').doc();
      final index = scores.indexOf(score);
      final Map<String, dynamic> scoreData = {
        'index': index,
        'type': score.type.name,
        'technique': score.technique.name,
        'target': score.target.name,
        'description': score.description,
        'homeScored': score.homeScored,
      };

      batch.set(scoreDoc, scoreData);
    }

    await batch.commit();
    return true;
  }

  static Future<KumiteMatch> fromQueryDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> match) async {
    final String title = match['title'];
    final String? description = match['description'];
    final String opponent = match['opponent'];
    final Timestamp dateTimeTiemStamp = match['dateTime'];
    final DateTime dateTime = dateTimeTiemStamp.toDate();
    final ScoringSystems scoringSystem =
        ScoringSystems.values.byName(match['scoringSystem'])!;
    final List<Score> scores = [];
    final QuerySnapshot<Map<String, dynamic>> scoreDocs = await match.reference
        .collection('scores')
        .orderBy(
          'index',
        )
        .get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> scoreDoc
        in scoreDocs.docs) {
      final int index = scoreDoc['index'];
      final String type = scoreDoc['type'];
      final String technique = scoreDoc['technique'];
      final String target = scoreDoc['target'];
      final String? description = scoreDoc['description'];
      final bool homeScored = scoreDoc['homeScored'];
      final possibleScores = scoringSystem.system.scoreTypes;
      final ScoreType scoreType = possibleScores.firstWhere(
          (scoreType) => scoreType.name == type,
          orElse: () => throw Exception('Invalid score type'));
      // final ScoreType scoreType = ScoringSystems.SKIF.system.scoreTypes.first;

      final Score score = Score(
        type: scoreType,
        technique: Techniques.values.byName(technique),
        target: Targets.values.byName(target),
        description: description,
        homeScored: homeScored,
      );
      scores.add(score);
    }

    return KumiteMatch(
      title: title,
      description: description,
      opponent: opponent,
      dateTime: dateTime,
      scoringSystem: scoringSystem,
      scores: scores,
    );
  }
}
