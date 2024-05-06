import 'package:ippon/model/karate/kumite/kumite_match.dart';

enum ClubTypes {
  karateKumite,
  karateKata,
}

//extend enum
extension TypesExtension on ClubTypes {
  String get name {
    switch (this) {
      case ClubTypes.karateKumite:
        return 'Kumite';
      case ClubTypes.karateKata:
        return 'Kata';
    }
  }

  dynamic get matchType {
    switch (this) {
      case ClubTypes.karateKumite:
        return KumiteMatch;
      case ClubTypes.karateKata:
        return null;
    }
  }
}
