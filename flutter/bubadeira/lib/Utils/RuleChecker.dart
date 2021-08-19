import 'dart:convert';

import 'package:bubadeira/Common/RulesMap.dart';
import 'package:bubadeira/Widgets/DrinkCard.dart';
import 'package:flutter/material.dart';

import 'Rule.dart';

class RuleChecker {
  RulesMap rules = new RulesMap();

  List<Widget> checkNumber(int number, int gameMode) {
    List<DrinkCard> cardsList;
    switch (gameMode) {
      case 0:
        if (number == 1) {
          cardsList = getAppliedDrinkCards(number);
          sortByPriorityLevel(cardsList);
          return cardsList.sublist(0, 1);
        } else {
          return [];
        }
      case 1:
        cardsList = getAppliedDrinkCards(number);
        sortByPriorityLevel(cardsList);
        return cardsList.isEmpty ? [] : cardsList.sublist(0, 1);
      case 2:
        return getAppliedDrinkCards(number);
      default:
        return [];
    }
  }

  void sortByPriorityLevel(List<DrinkCard> cardsList) {
    cardsList.sort((r1, r2) => r2.priorityLevel.compareTo(r1.priorityLevel));
  }

  List<DrinkCard> getAppliedDrinkCards(int number) {
    List<DrinkCard> cardsList = [];
    for (Rule r in rules.getRulesMap().values) {
      if (r.checkExpression(number)) {
        if (r.variable) {
          r.setNShots(number);
        }
        r.card.nShots = r.nShots!;
        cardsList.add(r.card);
      }
    }
    return cardsList;
  }
}
