import 'dart:math';

import 'package:bubadeira/Common/GameModes.dart';
import 'package:bubadeira/Utils/RuleChecker.dart';
import 'package:flutter/material.dart';

import 'Common/Constant.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  RuleChecker _rc = new RuleChecker();
  Map _data = {};
  String _numero = '';
  GameMode? _selectedGameMode;
  int _novoNumero = 0;
  List<Widget> _cards = [];
  int _currentCardIndex = 1;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new PageController(initialPage: 0, keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context)!.settings.arguments as Map;
    _numero = _data['numero'];
    _selectedGameMode = _data['gameMode'];
    if (_novoNumero != 0) {
      _numero = _novoNumero.toString();
    } else {
      _cards = [];
    }
    int _numeroNumeric = int.parse(_numero);

    var _continueGamebuttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton.extended(
          backgroundColor: Constant.buttonColor,
          label: Text(
            'ROLL',
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          onPressed: () {
            setState(() {
              Random r = Random();
              _novoNumero = r.nextInt(_numeroNumeric) + 1;
              _cards = _rc.checkNumber(
                  _novoNumero, _selectedGameMode!.ruleCheckerState);
              _currentCardIndex = 1;

              //Tentar dar dispose aqui
              if (_cards.isNotEmpty && _controller.hasClients) {
                _controller.jumpToPage(0);
              }
            });
          },
        ),
      ],
    );

    var _gameOverbuttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: Constant.buttonColor,
          label: Text(
            'RETURN',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: Constant.buttonColor,
          label: Text(
            'RESTART',
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
          onPressed: () {
            setState(() {
              _currentCardIndex = 1;
              _novoNumero = 0;
            });
          },
        ),
      ],
    );

    var normalAppBar = AppBar(
      elevation: 0,
      backgroundColor: Constant.mainBackgroundColor,
      title: Text(
        _selectedGameMode!.name,
        style: TextStyle(fontSize: 40),
      ),
      centerTitle: true,
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
    );

    var gameOverAppBar = AppBar(
      elevation: 0,
      backgroundColor: Constant.mainBackgroundColor,
      title: Text(
        'GameOver',
        style: TextStyle(fontSize: 40),
      ),
      leading: Container(),
      centerTitle: true,
    );

    return Scaffold(
      backgroundColor: Constant.mainBackgroundColor,
      appBar: _numeroNumeric != 1 ? normalAppBar : gameOverAppBar,
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 60),
            alignment: Alignment.topCenter,
            child: Text(
              '$_numero',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: _numeroNumeric != 1
                ? _continueGamebuttonBar
                : _gameOverbuttonBar,
          ),
          _cards.length != 0
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      children: _cards,
                      onPageChanged: (value) {
                        setState(() {
                          this._currentCardIndex = value + 1;
                        });
                      },
                    ),
                  ),
                )
              : Container(),
          _cards.length > 1
              ? CardPageController(
                  controller: _controller,
                  currentCardIndex: _currentCardIndex,
                  cards: _cards)
              : SizedBox(height: 112),
        ],
      ),
    );
  }
}

class CardPageController extends StatelessWidget {
  const CardPageController({
    Key? key,
    required PageController controller,
    required int currentCardIndex,
    required List<Widget> cards,
  })  : _controller = controller,
        _currentCardIndex = currentCardIndex,
        _cards = cards,
        super(key: key);

  final PageController _controller;
  final int _currentCardIndex;
  final List<Widget> _cards;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Constant.buttonColor,
          iconSize: 80,
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            this._controller.previousPage(
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        ),
        Text(
          this._currentCardIndex.toString() + '/' + _cards.length.toString(),
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          color: Constant.buttonColor,
          iconSize: 80,
          icon: Icon(Icons.arrow_right),
          onPressed: () {
            this._controller.nextPage(
                duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
        ),
      ],
    );
  }
}
