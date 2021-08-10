import 'package:bubadeira/Widgets/DrinkCard.dart';
import 'package:flutter/material.dart';

class Rule {
  String name;
  String description;
  Function ruleExpression;
  DrinkCard card;

  Rule(this.name, this.description, this.ruleExpression) {
    this.card = new DrinkCard(
      description: this.description,
    );
  }

  bool checkExpression(int number) {
    return this.ruleExpression(number);
  }
}
