import '../Utils/Rule.dart';

class RulesMap {
  Map<int, Rule> _rules = {};

  RulesMap() {
    _rules = {
      1: new Rule(
          name: 'couvinhas de sabao aaaaaaaaaa',
          description:
              'Numero par, bebe! Numero par, bebe! Numero par, bebe! bebe! Numero par, bebe! bebe! Numero par, bebe! bebe!',
          ruleExpression: (int number) {
            return number.isOdd;
          },
          getNShots: (int number) {
            return number.toString().length;
          },
          variable: true,
          timeToFinish: 10),
      2: new Rule(
          name: 'regra 2',
          description: 'Numero impar, Manda beber!',
          ruleExpression: (int number) {
            return number.isOdd;
          },
          nShots: 4,
          variable: false),
      3: new Rule(
          name: 'Ganhaste meu filho',
          description:
              'Parece que chegaste ao fim e por isso tens de beber a garrafa toda eheh',
          ruleExpression: (int number) {
            return number == 1;
          },
          nShots: 1000,
          variable: false),
      4: new Rule(
          name: 'Teste de regra by chance',
          description:
              'Se isto funcionar até é bacano, devias beber um copo para festejar',
          ruleExpression: (int number) {},
          nShots: 20,
          variable: false,
          probability: 99)
    };
  }

  Map<int, Rule> getRulesMap() {
    return _rules;
  }
}
