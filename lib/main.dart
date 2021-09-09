import 'dart:math';

import 'package:flutter/material.dart';

import 'colors_list.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: HOME_TITLE_TEXT,
      theme: ThemeData(
        primarySwatch: PRIMARY_SWATCH_COLOR,
      ),
      home: MyHomePage(title: HOME_TITLE_TEXT),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = START_COLOR_VALUE;
  List<Color> _colorList = [];
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _bodyContent(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _navigateToColorsList();
        },
        label: Text(ACTION_BUTTON_TEXT),
      ),
    );
  }

  void generateRandomColor() {
    setState(() {
      _color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextDouble(),
      );
    });
    _colorList.add(_color);
  }

  Widget _bodyContent(){
    return InkWell(
      onTap: generateRandomColor,
      child: Container(
        color: _color,
        child: _textAlign(),
      ),
    );
  }

  Widget _textAlign(){
    return Align(
      alignment: Alignment.center,
      child: Text(
        CENTER_TEXT,
        textAlign: TextAlign.center,
        style: CENTER_TEXT_STYLE,
      ),
    );
  }

  Future _navigateToColorsList(){
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ColorsList(colors: _colorList)),
    );
  }

}

