import 'dart:math';

import 'package:bubadeira/Utils/RuleChecker.dart';
import 'package:flutter/material.dart';

import 'Common/Constant.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  RuleChecker rc = new RuleChecker();
  Map data = {};
  String _numero = '';
  int _novoNumero = 0;
  Widget _card;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    _numero = data['numero'];
    if (_novoNumero != 0) {
      _numero = _novoNumero.toString();
    } else {
      _card = null;
    }
    int numeroNumeric = int.parse(_numero);

    return Scaffold(
      backgroundColor: Constant.mainBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.mainBackgroundColor,
        leading: IconButton(
          iconSize: 35,
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.restore),
            onPressed: () {
              setState(() {
                _novoNumero = 0;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            alignment: Alignment.topCenter,
            child: Text(
              '$_numero',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: FloatingActionButton.extended(
              backgroundColor: Constant.buttonColor,
              label: Text(
                'ROLL',
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              onPressed: () {
                setState(() {
                  Random r = Random();
                  _novoNumero = r.nextInt(numeroNumeric) + 1;
                  _card = rc.checkNumber(_novoNumero);
                });
              },
            ),
          ),
          _card != null ? _card : Container(),
        ],
      ),
    );
  }
}
