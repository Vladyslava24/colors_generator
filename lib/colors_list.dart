import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ColorsList extends StatefulWidget {
  List<Color> colors;
  ColorsList({Key? key, required this.colors}) : super(key: key);

  @override
  _ColorsListState createState() => _ColorsListState(this.colors);
}

class _ColorsListState extends State<ColorsList> {
  final List<Color> _colors;
  final _saved = <Color>{};

  _ColorsListState(this._colors);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: NEW_SCREEN_TITLE_TEXT,
      home:Scaffold(
        appBar: _createAppBar(),
        body: ListView.builder(
            itemCount: _colors.length,
            itemBuilder: (context,index){
              final color = _colors[index];
              return _buildDismissible(color, index);
            }
        ),
      ),
    );
  }

  AppBar _createAppBar(){
    return AppBar(
      title: Text(APP_BAR_TITLE_TEXT),
      backgroundColor: APP_BAR_BACKGROUND,
      actions: [
        IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
      ],
    );
  }

  ListTile _buildListTile(Color color){
    final alreadySaved = _saved.contains(color);
    return ListTile(
      trailing: Icon(   //add heart icon
        alreadySaved ? FAVORITE_ICON : FAVORITE_BORDER_ICON,
        color: alreadySaved ? FAVOURITES_COLOR : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(color);
          } else {
            _saved.add(color);
          }
        });
      },
    );
  }

  Dismissible _buildDismissible(Color color, index){
    return Dismissible(
      child: Container(
        height: 120,
        color: color,
        child: _buildListTile(color),
      ),
      key: Key(_colors[index].toString()),
      onDismissed: (direction) {
        setState(() {
          _colors.removeAt(index);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _createSavedColorMap();
          final divided = _divideTiles(tiles);
          return Scaffold(
            appBar: AppBar(
              title: Text(SAVED_COLORS_TITLE_TEXT),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Iterable<Container> _createSavedColorMap(){
    return _saved.map(
          (Color color) {
        return Container(
          height: 120,
          color: color,
        );
      },
    );
  }

  List<Widget> _divideTiles(tiles){
    return tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
  }
}

