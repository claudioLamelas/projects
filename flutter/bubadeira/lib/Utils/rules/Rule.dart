import 'dart:math';

import 'package:bubadeira/Common/RuleExpressions.dart';
import 'package:bubadeira/Common/RuleNShotsExpressions.dart';
import 'package:bubadeira/Utils/Tuple.dart';

class Rule {
  String name;
  String description;
  int? nShots;
  Tuple<int, int> ruleExpression;
  Tuple<int, int>? getNShots;
  bool variable;
  int probability; //Se uma regra tiver este campo preenchido então é uma regra que se verifica dada essa probabilidade
  double timeToFinish;
  int priorityLevel;

  Rule(
      {required this.name,
      required this.description,
      required this.ruleExpression,
      this.nShots,
      this.getNShots,
      required this.variable,
      this.probability = 0,
      this.timeToFinish = 0,
      required this.priorityLevel});

  bool checkExpression(int number) {
    if (this.probability > 0) {
      return tryProbability(this.probability);
    } else {
      Function expression =
          RuleExpressions.expressions[this.ruleExpression.item1]!;
      if (this.ruleExpression.item2 != null) {
        return expression(number, this.ruleExpression.item2);
      } else {
        return expression(number);
      }
    }
  }

  void setNShots(int number) {
    Function expression =
        RuleNShotsExpressions.expressions[this.getNShots!.item1]!;
    this.nShots = expression(number);
  }

  bool tryProbability(int probability) {
    Random r = new Random();
    return r.nextInt(100) + 1 <= probability;
  }

  Map toJson() {
    return {
      'name': name,
      'description': description,
      'nShots': nShots,
      'ruleExpression': ruleExpression.toJson(),
      'getNShots': getNShots?.toJson(),
      'variable': variable,
      'probability': probability,
      'timeToFinish': timeToFinish,
      'priorityLevel': priorityLevel
    };
  }

  static Rule fromJson(e) {
    Tuple<int, int> ruleExpression =
        new Tuple(e['ruleExpression']['item1'], e['ruleExpression']['item2']);

    if (e['variable']) {
      Tuple<int, int> getNShots =
          new Tuple(e['getNShots']['item1'], e['getNShots']['item2']);
      Rule r = new Rule(
        name: e['name'],
        description: e['description'],
        ruleExpression: ruleExpression,
        variable: e['variable'],
        priorityLevel: e['priorityLevel'],
        probability: e['probability'],
        timeToFinish: e['timeToFinish'],
        getNShots: getNShots,
      );
      return r;
    } else {
      Rule r = new Rule(
        name: e['name'],
        description: e['description'],
        ruleExpression: ruleExpression,
        variable: e['variable'],
        priorityLevel: e['priorityLevel'],
        probability: e['probability'],
        timeToFinish: e['timeToFinish'],
        nShots: e['nShots'],
      );
      return r;
    }
  }
}
