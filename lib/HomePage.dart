import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tubes_app/LoginPage.dart';
import 'package:tubes_app/RecipePage.dart';
import 'model/Recipe.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const Home());
}

Future<List<Recipe>> fetchRecipe() async {
  final res =
      await http.get(Uri.parse('http://192.168.0.110:8000/api/recipes'));
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    var parsed = data.cast<Map<String, dynamic>>();
    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed');
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Recipe>> recipes;

  @override
  void initState() {
    super.initState();
    recipes = fetchRecipe();
    print(recipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 250,
                child: TextField(
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Cari Resep..."),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 200.0),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipePage()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Center(
                        child: Text(
                          '$i',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'Others for You!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(20),
              children:
                  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].map((i) {
                return Builder(builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipePage()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.teal),
                      child: Center(
                        child: Text(
                          '$i',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
