import '../Utils/Rule.dart';

class RulesMap {
  Map<int, Rule> _rules;

  RulesMap() {
    _rules = {
      1: new Rule('regra 1', 'Numero par, bebe!', (int number) {
        return number.isEven;
      }),
      2: new Rule('regra 2', 'Numero impar, Manda beber!', (int number) {
        return number.isOdd;
      })
    };
  }

  Map<int, Rule> getRulesMap() {
    return _rules;
  }
}
