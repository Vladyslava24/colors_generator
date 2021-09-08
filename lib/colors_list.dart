import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorsList extends StatefulWidget {
  List<Color> colors;
  ColorsList({Key? key, required this.colors}) : super(key: key);

  @override
  ColorsListState createState() => ColorsListState(this.colors);
}

class ColorsListState extends State<ColorsList> {
  final List<Color> colors;
  final _saved = <Color>{};

  ColorsListState(this.colors);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
                  (Color color) {
                return Container(
                  height: 120,
                  color: color,
                    );
                  },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(context: context, tiles: tiles).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Generated colors screen",
      home:Scaffold(
        appBar: AppBar(
          title: Text("Generated colors"),
          backgroundColor: Colors.pinkAccent,
          actions: [
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: ListView.builder(
            itemCount: colors.length,
            itemBuilder: (context,index){
              final color = colors[index];
              final alreadySaved = _saved.contains(color);
              return Dismissible(
                child: Container(
                    height: 120,
                    color: color,
                    child: ListTile(
                      trailing: Icon(   //add heart icon
                        alreadySaved ? Icons.favorite : Icons.favorite_border,
                        color: alreadySaved ? Colors.red : null,
                    ),
                      onTap: () {      // NEW lines from here...
                        setState(() {
                          if (alreadySaved) {
                            _saved.remove(color);
                          } else {
                            _saved.add(color);
                          }
                        });
                      },

                    ),
                ),
                  key: Key(colors[index].toString()),
                  onDismissed: (direction) {
                    setState(() {
                      colors.removeAt(index);
                    });
                  },
              );
            }
        ),
      ),
    );
  }
}

