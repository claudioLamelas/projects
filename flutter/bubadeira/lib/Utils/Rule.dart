import 'dart:math';

import 'package:bubadeira/Widgets/DrinkCard.dart';
import 'package:flutter/material.dart';

class Rule {
  String name;
  String description;
  int? nShots;
  Function ruleExpression;
  Function? getNShots;
  late DrinkCard card;
  bool variable;
  int probability; //Se uma regra tiver este campo preenchido então é uma regra que se verifica dada essa probabilidade
  double timeToFinish;

  Rule(
      {required this.name,
      required this.description,
      required this.ruleExpression,
      this.nShots,
      this.getNShots,
      required this.variable,
      this.probability = 0,
      this.timeToFinish = 0}) {
    this.card = new DrinkCard(
      name: this.name,
      description: this.description,
      timeToFinish: this.timeToFinish,
    );
  }

  bool checkExpression(int number) {
    if (this.probability > 0) {
      return tryProbability(this.probability);
    } else {
      return this.ruleExpression(number);
    }
  }

  void setNShots(int number) {
    this.nShots = this.getNShots!(number);
  }

  bool tryProbability(int probability) {
    Random r = new Random();
    return r.nextInt(100) + 1 <= probability;
  }
}
