enum ScoringSystems {
  SKIF,
  IJKA,
  WKF,
}

extension ScoringSystemsExtension on ScoringSystems {
  ScoringSystem get system {
    switch (this) {
      case ScoringSystems.SKIF:
        return ScoringSystem(
          scoresToWin: 3,
          title: 'SKIF Ippon-Han',
          scoreTypes: [
            ScoreType(id: "ippon", name: "ippon", value: 2),
            ScoreType(id: "wazari", name: "waza-ari", value: 1),
          ],
        );
      case ScoringSystems.IJKA:
        return ScoringSystem(
          scoresToWin: 2,
          title: 'IJKA',
          scoreTypes: [
            ScoreType(id: "ippon", name: "ippon", value: 2),
            ScoreType(id: "wazari", name: "waza-ari", value: 1),
          ],
        );
      case ScoringSystems.WKF:
        return ScoringSystem(
          scoresToWin: 2,
          title: 'IJKA',
          scoreTypes: [
            ScoreType(id: "ippon", name: "ippon", value: 2),
            ScoreType(id: "wazari", name: "waza-ari", value: 1),
          ],
        ); // Point value for WKF scoring system
      default:
        throw Exception('Invalid scoring system');
    }
  }
}

class ScoreType {
  final id;
  final name;
  final value;

  ScoreType({required this.name, required this.value, required this.id});
}

class ScoringSystem {
  final String title;
  final int scoresToWin;
  final List<ScoreType> scoreTypes;

  ScoringSystem({
    required this.scoresToWin,
    required this.title,
    required this.scoreTypes,
  });
}
