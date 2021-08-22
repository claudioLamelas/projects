import 'package:bubadeira/Common/Constant.dart';
import 'package:bubadeira/Common/GameModes.dart';
import 'package:bubadeira/Pages/Rules/RuleListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Common/GameModes.dart';
import 'Pages/Game/CronometerPage.dart';
import 'Pages/Game/GamePage.dart';
import 'Widgets/BottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/home',
      routes: {
        '/home': (context) => MyHomePage(title: ''),
        '/game': (context) => GamePage(),
        '/cronometer': (context) => CronometerPage(),
        '/rulesList': (context) => RuleListPage(),
      },
      theme: ThemeData(
        // primarySwatch: Colors.deepOrange,
        primaryColor: Constant.footer_icon_Color,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController maxNumberController = new TextEditingController();
  List<GameMode> gameModes = new GameModes().gameModes;
  GameMode? selectedGameMode;
  int selectedGameModeIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constant.mainBackgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 35,
            onPressed: () {
              print(this.selectedGameMode?.name);
            },
          )
        ],
      ),
      backgroundColor: Constant.mainBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 100),
            child: TextField(
              controller: maxNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(fontSize: 50.0),
              textAlign: TextAlign.center,
              showCursor: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                filled: true,
                fillColor: Constant.inputColor,
                hintText: 'Número de Partida',
                hintStyle: TextStyle(fontSize: 30.0),
                // errorText: _validateInput(maxNumberController.text),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Constant.inputBorderColor,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Constant.inputBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          ButtonBar(
            //Maybe i can extract this widget to make setState more performant
            alignment: MainAxisAlignment.center,
            children: [
              for (var gameMode in this.gameModes)
                ElevatedButton(
                  child: Text(gameMode.name),
                  style: this.selectedGameModeIndex ==
                          this.gameModes.indexOf(gameMode)
                      ? ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red))
                      : ButtonStyle(),
                  onPressed: () {
                    setState(() {
                      this.selectedGameMode = gameMode;
                      this.selectedGameModeIndex =
                          this.gameModes.indexOf(gameMode);
                    });
                  },
                )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: FloatingActionButton.extended(
              backgroundColor: Constant.buttonColor,
              label: Text(
                'START',
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              onPressed: () {
                setState(() {
                  if (maxNumberController.text.isNotEmpty &&
                      int.parse(maxNumberController.text) > 1 &&
                      this.selectedGameMode != null) {
                    FocusScope.of(context).unfocus(); //hides keyboard
                    Navigator.pushNamed(context, '/game', arguments: {
                      'numero': maxNumberController.text,
                      'gameMode': selectedGameMode
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        activeIndex: 0,
      ),
    );
  }

  String? _validateInput(String number) {
    if (number.length <= 0 || number == null) {
      return 'Insere um número';
    } else {
      return null;
    }
  }
}
