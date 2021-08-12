import 'package:bubadeira/Common/RulesMap.dart';
import 'package:flutter/material.dart';

import 'Rule.dart';

class RuleChecker {
  RulesMap rules = new RulesMap();

  List<Widget> checkNumber(int number) {
    List<Widget> cardsList = [];
    for (Rule r in rules.getRulesMap().values) {
      if (r.checkExpression(number)) {
        if (r.variable) {
          r.setNShots(number);
        }
        r.card.nShots = r.nShots;
        cardsList.add(r.card);
      }
    }
    return cardsList;
  }
}
