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
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: Center(
        child: Text('Recipe'),
      ),
    );
  }
}
