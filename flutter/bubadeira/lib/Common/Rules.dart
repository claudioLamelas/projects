import 'dart:convert';

import 'package:bubadeira/Utils/Tuple.dart';

import '../Utils/rules/Rule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rules {
  static const String RULES_PREFERENCES_KEY = 'rules';
  static List<Rule> _initialRules = [
    new Rule(
        name: 'couvinhas de sabao aaaaaaaaaa',
        description:
            'Numero par, bebe! Numero par, bebe! Numero par, bebe! bebe! Numero par, bebe! bebe! Numero par, bebe! bebe!',
        ruleExpression: new Tuple(1, null),
        getNShots: new Tuple(0, null),
        variable: true,
        timeToFinish: 10,
        priorityLevel: 1),
    new Rule(
        name: 'regra 2',
        description: 'Numero impar, Manda beber!',
        ruleExpression: new Tuple(2, null),
        nShots: 4,
        variable: false,
        priorityLevel: 1),
    new Rule(
        name: 'Ganhaste meu filho',
        description:
            'Parece que chegaste ao fim e por isso tens de beber a garrafa toda eheh',
        ruleExpression: new Tuple(0, null),
        nShots: 1000,
        variable: false,
        priorityLevel: 5),
    new Rule(
        name: 'Teste de regra by chance',
        description:
            'Se isto funcionar até é bacano, devias beber um copo para festejar',
        ruleExpression: new Tuple(-1, null),
        nShots: 20,
        variable: false,
        probability: 40,
        priorityLevel: 2),
    new Rule(
        name: 'Teste de regra by chance 2',
        description: 'Esta é a segunda Carta By Chance!!!',
        ruleExpression: new Tuple(-1, null),
        nShots: 40,
        variable: false,
        probability: 80,
        priorityLevel: 2),
    new Rule(
        name: 'Regra do igual a um numero',
        description: 'Calhou um numero muito especifico',
        ruleExpression: new Tuple(3, 2),
        nShots: 3,
        variable: false,
        priorityLevel: 1),
  ];

  //Deixar assim por agora mas não está feito da melhor maneira
  static final Future<List<Rule>> rules =
      _initializeRules().then((value) => value);

  static Future<List<Rule>> _initializeRules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(RULES_PREFERENCES_KEY)) {
      await prefs.setString(RULES_PREFERENCES_KEY, jsonEncode(_initialRules));
      return _initialRules;
    } else {
      List<dynamic> rules = jsonDecode(prefs.getString(RULES_PREFERENCES_KEY)!);
      List<Rule> rulesFinal = rules.map((e) => Rule.fromJson(e)).toList();
      return rulesFinal;
    }
  }
}
