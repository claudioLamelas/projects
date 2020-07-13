import 'package:flutter/material.dart';

import 'HomePage/CarrinhoCompras.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Lista'),
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
  int _counter = 0;
  var items = [];

  void _newItemList() {
    setState(() {
      items.add(1.0);
    });
  }

  void _clearList() {
    setState(() {
      items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings_overscan),
            onPressed: _clearList,
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 150.0),
            child: Container(
              child: ListView.separated(
                controller: ScrollController(),
                itemCount: items.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 1.5),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.63,
            right: MediaQuery.of(context).size.width * 0.43,
            child: FloatingActionButton(
              onPressed: _newItemList,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
          CarrinhoCompras(),
        ],
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: Container(color: Colors.blue,)
      ),
    );
  }
}
