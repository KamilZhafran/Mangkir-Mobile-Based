import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_app/LoginPage.dart';
import 'package:tubes_app/model/Recipe.dart';
import 'package:http/http.dart' as http;

Future<List<Recipe>> fetchMyRecipe() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  print(email);
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final uri = Uri.parse('http://192.168.0.111:8000/api/recipes')
      .replace(queryParameters: {'email': email});
  final res = await http.get(uri, headers: headers);
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    var parsed = data.cast<Map<String, dynamic>>();
    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed');
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<Recipe>> MyRecipes;
  late Future<String?> email;
  @override
  void initState() {
    super.initState();
    MyRecipes = fetchMyRecipe();
    email = getEmail();
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('email');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('email');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 55,
                child: Icon(Icons.person, size: 100, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<String?>(
                future: email,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final email = snapshot.data!;
                    return Text(
                      email,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    );
                  } else {
                    return Text('No data');
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                    title: Text('Are you sure?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text('You will be logged out'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          logout();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      ),
                    ],
                  );

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Text('Logout'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Favorites",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 15),
              Expanded(
                  child: FutureBuilder(
                future: MyRecipes,
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
                                    color: Colors.blue, shape: BoxShape.circle),
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
                                  Text('Durasi: ${recipe.durasi} menit')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("Tidak ada data");
                  }
                },
              ))
            ],
          ),
        ),
      )),
    );
  }
}
