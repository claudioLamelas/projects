class GameModes {
  List<GameMode> _gameModes = [];

  GameModes() {
    _gameModes = [
      new GameMode(
          name: 'Zen',
          description:
              'Game mode where there are no consequences until the very last one.',
          ruleCheckerState: 0),
      new GameMode(
          name: 'Normal',
          description:
              'Game mode where can only be one consequence per number.',
          ruleCheckerState: 1),
      new GameMode(
          name: 'Hardcore',
          description: 'No limit to the number of consequences.',
          ruleCheckerState: 2)
    ];
  }

  List<GameMode> get gameModes => _gameModes;
}

class GameMode {
  String name;
  String description;
  int ruleCheckerState;

  GameMode(
      {required this.name,
      required this.description,
      required this.ruleCheckerState});
}
