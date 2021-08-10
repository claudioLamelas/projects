import 'package:bubadeira/Common/Constant.dart';
import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  String description;

  DrinkCard({Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constant.inputColor,
      ),
      child: Text('$description'),
    );
  }
}
