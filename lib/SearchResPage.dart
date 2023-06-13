import 'dart:convert';

import 'package:flutter/material.dart';
import 'model/Recipe.dart';
import 'package:http/http.dart' as http;
import 'FilterPage.dart';
import 'constants/API.dart';

Future<List<Recipe>> searchRecipe(
    String keyword, String kategori, String durasi) async {
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final uri = Uri.parse('${API.BASE_URL}/search').replace(queryParameters: {
    'keyword': keyword,
    'durasi': durasi,
    'category': kategori,
  });
  final res = await http.get(uri, headers: headers);
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    var parsed = data.cast<Map<String, dynamic>>();
    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed');
  }
}

class SearchResPage extends StatefulWidget {
  final String keyword;
  final String kategori;
  final String durasi;

  const SearchResPage({
    required this.keyword,
    required this.kategori,
    required this.durasi,
    Key? key,
  }) : super(key: key);

  @override
  _SearchResPageState createState() => _SearchResPageState();
}

class _SearchResPageState extends State<SearchResPage> {
  late Future<List<Recipe>> recipes;

  @override
  void initState() {
    super.initState();
    print([widget.keyword, widget.kategori, widget.durasi]);
    recipes = searchRecipe(widget.keyword, widget.kategori, widget.durasi);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: 300,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      const SizedBox(width: 10),
                      Text(
                        'Cari Resep...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<Recipe>>(
          future: recipes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final recipeList = snapshot.data!;
              return ListView.builder(
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  final recipe = recipeList[index];
                  return GestureDetector(
                    onTap: () {
                      // nanti disini pindah
                      print(recipe.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors
                                .blue, // Replace with your desired color or image
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.restaurant_menu_sharp,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          recipe.judul,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kategori: ${recipe.kategori}'),
                            Text('Durasi: ${recipe.durasi}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ),
      ),
    );
  }
}
