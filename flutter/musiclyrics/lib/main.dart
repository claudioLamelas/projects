import 'dart:convert';
import 'ShowLyrics.dart';
import 'SearchLyrics.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'GetSomeLyrics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _lyrics;
  bool onLyricsPage = false;
  String songTitle;

  String userRequest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(onLyricsPage ? songTitle : widget.title),
          leading: onLyricsPage
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: returnToMainPage,
                )
              : null),
      body: onLyricsPage
          ? ShowLyrics(
              lyrics: _lyrics,
            )
          : SearchLyrics(userRequest: userRequest),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => print(userRequest),
        child: Icon(Icons.music_note),
      ),
    );
  }

// ignore: missing_return
  Future<String> _getlyrics() async {
    String url =
        "https://canarado-lyrics.p.rapidapi.com/lyrics/britney%2520spears%2520toxic";

    var headers = {
      'x-rapidapi-host': "canarado-lyrics.p.rapidapi.com",
      'x-rapidapi-key': "c67a843d17msh9a57e540bff02f7p183fb2jsn63e0c239b187"
    };

    http.Response response = await http.get(url, headers: headers);
    var responseJson = json.decode(response.body);

    setState(() {
      onLyricsPage = true;
      songTitle = responseJson['content'][0]['title'];
      _lyrics = responseJson['content'][0]['lyrics'];
    });
  }

  void returnToMainPage() {
    setState(() {
      onLyricsPage = false;
    });
  }
}
