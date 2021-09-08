import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colors Generator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Colors Generator'),
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
  Color _color = Color(0xFFFFFFFF);
  final Random _random = Random();

  void generateRandomColor() {
    setState(() {
      _color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: InkWell(
        onTap: generateRandomColor,
        child: Container(
          color: _color,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Hey there',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.deepPurple
              ),
            ),
          ),
        ),
      ),
    );
  }
}
