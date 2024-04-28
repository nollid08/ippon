enum Targets {
  jodan,
  chudan,
  gedan,
}

extension TargetsExtension on Targets {
  Target get info {
    switch (this) {
      case Targets.jodan:
        return Target(
          englishName: 'Head',
          japaneseName: 'Jodan',
        );
      case Targets.chudan:
        return Target(
          englishName: 'Trunk',
          japaneseName: 'Chudan',
        );
      case Targets.gedan:
        return Target(
          englishName: 'Below The Belt',
          japaneseName: 'Gidan',
        );
      default:
        throw Exception('Invalid target');
    }
  }
}

class Target {
  final String englishName;
  final String japaneseName;

  Target({required this.englishName, required this.japaneseName});
}
