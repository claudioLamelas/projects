import 'package:bubadeira/Common/Constant.dart';
import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  final String name;
  final String description;
  final double? timeToFinish;
  late int nShots; // ver ser consigo tornar isto num late final
  final bool isChance;
  final int priorityLevel;

  DrinkCard(
      {Key? key,
      required this.name,
      required this.description,
      this.timeToFinish,
      required this.isChance,
      required this.priorityLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 350, //mudar para que seja mediante o tamanho do ecrã
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constant.inputColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Container(
              // margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$name',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Divider(color: Colors.black),
          Flexible(
            flex: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '$description',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          timeToFinish! > 0
              ? IconButton(
                  icon: Icon(Icons.timer),
                  onPressed: () => Navigator.pushNamed(context, '/cronometer',
                      arguments: {'time': timeToFinish}),
                )
              : Container(),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: 5, right: 20),
                child: Text(
                  'SHOTS: $nShots',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
