import 'package:bubadeira/Common/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'GamePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/game': (context) => GamePage(),
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
  MyHomePage({Key key, this.title}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.mainBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
                  child: TextField(
                    controller: maxNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
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
                        borderSide:
                            BorderSide(color: Constant.inputBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
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
                        if (maxNumberController.text.isNotEmpty) {
                          Navigator.pushNamed(context, '/game',
                              arguments: {'numero': maxNumberController.text});
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Constant.footerColor,
        items: [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.local_drink,
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Rules'),
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            title: Text('Memories'),
            icon: Icon(Icons.photo_album),
          ),
        ],
      ),
    );
  }

  String _validateInput(String number) {
    if (number.length <= 0 || number == null) {
      return 'Insere um número';
    } else {
      return null;
    }
  }
}
