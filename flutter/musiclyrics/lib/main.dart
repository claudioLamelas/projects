import 'dart:convert';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  // ignore: missing_return
  Future<String> _getdata() async {
    String url =
        "https://canarado-lyrics.p.rapidapi.com/lyrics/britney%2520spears%2520toxic";
    var headers = {
      'x-rapidapi-host': "canarado-lyrics.p.rapidapi.com",
      'x-rapidapi-key': "c67a843d17msh9a57e540bff02f7p183fb2jsn63e0c239b187"
    };
    http.Response response = await http.get(url, headers: headers);

    var data = json.decode(response.body);

    setState(() {
      _data = data['content'][0]['lyrics'];
    });
  }

  String _data;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollcontroller;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        controller: scrollcontroller,
        child: Center(
          child: Text(
            _data == null ? 'Loading' : _data,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getdata,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
