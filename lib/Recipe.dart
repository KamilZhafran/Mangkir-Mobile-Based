// create a blank screen here with state

import 'package:flutter/material.dart';

void main() {
  runApp(const Recipe());
}

class Recipe extends StatefulWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            
            bottom: TabBar(
              tabs: [
                Tab(text: 'FIRST'),
                Tab(text: 'SECOND',),
                Tab(text: 'THIRD'),
              ],
            ),
            title:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Container(
                    color: Colors.grey,
                  )
                )
              ),
          ),
          body: TabBarView(
            children: [
             Text('1'),
             Text('2'),
             Text('3')
            ],
          ),
        ),
      ),
    );
  }
}
