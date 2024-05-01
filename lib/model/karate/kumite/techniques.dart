enum Techniques {
  oizuki, // Stepping punch
  gyakuzuki, // Reverse punch
  maeGeri, // Front kick
  mawashiGeri, // Roundhouse kick
  yokoGeriKekomi, // Side thrust kick
  yokoGeriKeage, // Side snap kick
  ushiroGeri, // Back kick
  kizamiZuki, // Jab punch
  tettsuiUchi, // Hammer fist strike
  ashiBarai, // Foot sweep
  tobiMaeGeri, // Jumping front kick
  tobiYokoGeri, // Jumping side kick
  tobiMawashiGeri, // Jumping roundhouse kick
}

extension TechniquesExtensions on Techniques {
  Technique get data {
    switch (this) {
      case Techniques.oizuki:
        return Technique(
          japaneseName: 'Oizuki',
          englishName: 'Stepping punch',
        );
      case Techniques.gyakuzuki:
        return Technique(
          japaneseName: 'Gyakuzuki',
          englishName: 'Reverse punch',
        );
      case Techniques.maeGeri:
        return Technique(
          japaneseName: 'Mae geri',
          englishName: 'Front kick',
        );
      case Techniques.mawashiGeri:
        return Technique(
          japaneseName: 'Mawashi geri',
          englishName: 'Roundhouse kick',
        );
      case Techniques.yokoGeriKekomi:
        return Technique(
          japaneseName: 'Yoko geri kekomi',
          englishName: 'Side thrust kick',
        );
      case Techniques.yokoGeriKeage:
        return Technique(
          japaneseName: 'Yoko geri keage',
          englishName: 'Side snap kick',
        );
      case Techniques.ushiroGeri:
        return Technique(
          japaneseName: 'Ushiro geri',
          englishName: 'Back kick',
        );
      case Techniques.kizamiZuki:
        return Technique(
          japaneseName: 'Kizami zuki',
          englishName: 'Jab punch',
        );
      case Techniques.tettsuiUchi:
        return Technique(
          japaneseName: 'Tettsui uchi',
          englishName: 'Hammer fist strike',
        );
      case Techniques.ashiBarai:
        return Technique(
          japaneseName: 'Ashi barai',
          englishName: 'Foot sweep',
        );
      case Techniques.tobiMaeGeri:
        return Technique(
          japaneseName: 'Tobi mae geri',
          englishName: 'Jumping front kick',
        );
      case Techniques.tobiYokoGeri:
        return Technique(
          japaneseName: 'Tobi yoko geri',
          englishName: 'Jumping side kick',
        );
      case Techniques.tobiMawashiGeri:
        return Technique(
          japaneseName: 'Tobi mawashi geri',
          englishName: 'Jumping roundhouse kick',
        );
    }
  }
}

class Technique {
  final String japaneseName;
  final String englishName;

  Technique({
    required this.japaneseName,
    required this.englishName,
  });
}
