import 'package:bubadeira/Widgets/DrinkCard.dart';
import 'package:flutter/material.dart';

class Rule {
  String name;
  String description;
  int nShots;
  Function ruleExpression;
  Function getNShots;
  DrinkCard card;
  bool variable;

  Rule(
      {@required this.name,
      @required this.description,
      @required this.ruleExpression,
      this.nShots,
      this.getNShots,
      @required this.variable}) {
    this.card = new DrinkCard(
      name: this.name,
      description: this.description,
    );
  }

  bool checkExpression(int number) {
    return this.ruleExpression(number);
  }

  void setNShots(int number) {
    this.nShots = this.getNShots(number);
  }
}
