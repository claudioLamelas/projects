import 'package:flutter/material.dart';

class SearchLyrics extends StatefulWidget {
  SearchLyrics({this.userRequest});

  String userRequest;

  @override
  _SearchLyricsState createState() => _SearchLyricsState();
}

class _SearchLyricsState extends State<SearchLyrics> {
  TextEditingController _textcontroller;

  void initState() {
    super.initState();
    _textcontroller = TextEditingController(text: 'Glass Animals Denzel Curry');
  }

  void dispose() {
    _textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child:
              Text('Introduz o nome da musica e o artista a que pertence :)'),
        ),
        Center(
          child: Container(
            width: 370,
            child: TextField(
              controller: _textcontroller,
              showCursor: false,
              decoration: InputDecoration(
                hintText: 'Ex: Tokyo drifting Glass Animals',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() {
                widget.userRequest = value;
                print(widget.userRequest);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
