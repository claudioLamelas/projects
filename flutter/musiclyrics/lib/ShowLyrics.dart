import 'package:flutter/material.dart';

class ShowLyrics extends StatefulWidget {
  ShowLyrics({this.lyrics});
  final String lyrics;
  @override
  _ShowLyricsState createState() => _ShowLyricsState();
}

class _ShowLyricsState extends State<ShowLyrics> {
  ScrollController _scrollcontroller;

  void initState() {
    super.initState();
    _scrollcontroller = ScrollController();
  }

  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollcontroller,
      child: Center(
        child: Text(
          widget.lyrics,
        ),
      ),
    );
  }
}
