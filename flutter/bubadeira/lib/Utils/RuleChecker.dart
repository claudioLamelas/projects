import 'dart:math';
import "package:collection/collection.dart";

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
        int normalCardsLimit = 1;
        int chanceCardsLimit = 1;

        cardsList = getAppliedDrinkCards(number);

        List<DrinkCard> chanceCardsList = retrieveChanceCards(cardsList);

        sortByPriorityLevel(cardsList);
        sortByPriorityLevel(chanceCardsList);

        List<DrinkCard> finalCardsList = [];
        if (cardsList.isNotEmpty) {
          finalCardsList.addAll(pickDrinkCards(cardsList, normalCardsLimit));
        }

        if (chanceCardsList.isNotEmpty) {
          finalCardsList
              .addAll(pickDrinkCards(chanceCardsList, chanceCardsLimit));
        }

        return finalCardsList;
      case 2:
        int normalCardsLimit = 10000;
        int chanceCardsLimit = 3;

        cardsList = getAppliedDrinkCards(number);

        List<DrinkCard> chanceCardsList = retrieveChanceCards(cardsList);

        sortByPriorityLevel(cardsList);
        sortByPriorityLevel(chanceCardsList);

        List<DrinkCard> finalCardsList = [];
        if (cardsList.isNotEmpty) {
          finalCardsList.addAll(pickDrinkCards(cardsList, normalCardsLimit));
        }

        if (chanceCardsList.isNotEmpty) {
          finalCardsList
              .addAll(pickDrinkCards(chanceCardsList, chanceCardsLimit));
        }
        return finalCardsList;
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

  //vai buscar e remove as chanceCards da cardsList
  List<DrinkCard> retrieveChanceCards(List<DrinkCard> cardsList) {
    List<DrinkCard> chanceCardsList =
        cardsList.where((card) => card.isChance).toList();

    cardsList.removeWhere((card) => card.isChance);
    return chanceCardsList;
  }

  List<DrinkCard> pickDrinkCards(List<DrinkCard> cardsList, int cardsLimit) {
    List<DrinkCard> result = [];
    var teste = groupBy(cardsList, (DrinkCard card) => card.priorityLevel);
    for (var t in teste.values) {
      if (result.length < cardsLimit) {
        t.shuffle();
        result.addAll(t.take(min(t.length, cardsLimit)));
      } else {
        break;
      }
    }
    return result;
  }
}
