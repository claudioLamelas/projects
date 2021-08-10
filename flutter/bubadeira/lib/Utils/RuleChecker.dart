import 'package:bubadeira/Common/RulesMap.dart';
import 'package:flutter/material.dart';

import 'Rule.dart';

class RuleChecker {
  RulesMap rules = new RulesMap();

  Widget checkNumber(int number) {
    for (Rule r in rules.getRulesMap().values) {
      if (r.checkExpression(number)) {
        return r.card;
      }
    }
    return null;
  }
}
