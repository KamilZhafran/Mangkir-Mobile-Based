import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_app/LoginPage.dart';
import 'package:tubes_app/ProfilePage.dart';
import 'package:tubes_app/RecipePage.dart';
import 'package:tubes_app/FilterPage.dart';
import 'model/Recipe.dart';
import 'package:http/http.dart' as http;
import 'package:tubes_app/constants/API.dart';

void main() {
  runApp(const Home());
}

Future<List<Recipe>> fetchRecipe() async {
  final res = await http.get(Uri.parse('${API.BASE_URL}/recipes'));
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

  List imagesCarousel = [
    'assets/images/Picture1.png',
    'assets/images/Picture2.png',
    'assets/images/Picture3.png',
  ];

  List imgList = [
    'assets/images/Picture1.png',
    'assets/images/Picture2.png',
    'assets/images/Picture3.png',
  ];

  @override
  void initState() {
    super.initState();
    recipes = fetchRecipe();
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder<List<Recipe>>(
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800)),
                    items: imgList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              print(recipes);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipePage(
                                        id: snapshot
                                            .data![imgList.toList().indexOf(i)]
                                            .id)),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(i), fit: BoxFit.cover),
                                  color: Colors.amber),
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
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              future: recipes),
          // CarouselSlider(
          //   options: CarouselOptions(
          //       height: 200.0,
          //       autoPlay: true,
          //       autoPlayAnimationDuration: const Duration(milliseconds: 800)),
          //   items: imagesCarousel.map((i) {
          //     return Builder(
          //       builder: (BuildContext context) {
          //         return GestureDetector(
          //           onTap: () {
          //             print(recipes);
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => RecipePage()),
          //             );
          //           },
          //           child: Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
          //             decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                     image: AssetImage(i), fit: BoxFit.cover),
          //                 color: Colors.amber),
          //             child: Center(
          //               child: Text(
          //                 '$i',
          //                 style: const TextStyle(fontSize: 16.0),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   }).toList(),
          // ),
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
          FutureBuilder<List<Recipe>>(
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        padding: const EdgeInsets.all(20),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Builder(builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipePage(
                                          id: snapshot.data![index].id)),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            imgList[index % imgList.length]),
                                        fit: BoxFit.cover),
                                    color: Colors.teal),
                                child: Center(
                                  child: Text(
                                    '$index',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ),
                            );
                          });
                        }),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
              future: recipes),
          // Expanded(
          //   child: GridView.count(
          //     crossAxisCount: 3,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //     padding: const EdgeInsets.all(20),
          //     children: imgGrid.map((i) {
          //       return Builder(builder: (BuildContext context) {
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => RecipePage()),
          //             );
          //           },
          //           child: Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
          //             decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                     image: AssetImage(i), fit: BoxFit.cover),
          //                 color: Colors.teal),
          //             child: Center(
          //               child: Text(
          //                 '$i',
          //                 style: const TextStyle(fontSize: 16.0),
          //               ),
          //             ),
          //           ),
          //         );
          //       });
          //     }).toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
