// TODO: TabBar still nembus content

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_app/model/Ingredient.dart';
import 'package:tubes_app/model/Tool.dart';
import 'dart:convert';
import './model/RecipedDetail.dart';
import 'constants/API.dart';
import 'main.dart';
import 'model/Recipe.dart';
import 'model/Step.dart';
import 'model/Comment.dart';

// void main() {
//   runApp(const RecipePage());
// }

class RecipePage extends StatefulWidget {
  final int id;
  const RecipePage({Key? key, required this.id}) : super(key: key);

  Future<Map<String, dynamic>> addFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');

    print(email);
    print(this.id.toString());

    final res =
        await http.post(Uri.parse('${API.BASE_URL}/recipes/favorite'), body: {
      'email': email,
      'id': this.id.toString(),
    });

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed: ${res.body}');
    }
  }

  void deleteFavorite() async {
    final res = await http
        .delete(Uri.parse('${API.BASE_URL}/recipes/favorite/${this.id}'));
    if (res.statusCode == 200) {
      print('berhasil menghapus');
    } else {
      throw Exception('Failed');
    }
  }

  @override
  State<RecipePage> createState() => _RecipePageState();
}

Future<List<Recipe>> fetchMyRecipe() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  print(email);
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final uri = Uri.parse('${API.BASE_URL}/recipes/favorite')
      .replace(queryParameters: {'email': email});
  final res = await http.get(uri, headers: headers);
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    var parsed = data['dataRecipes'].cast<Map<String, dynamic>>();
    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  } else {
    throw Exception('Failed fetching favorite');
  }
}

Future<void> postComment(
    _email, _rating, _recipeID, _deskripsi, BuildContext context) async {
  final res = await http.put(Uri.parse('${API.BASE_URL}/recipe/${_recipeID}'),
      body: {'email': _email, 'rating': _rating, 'deskripsi': _deskripsi});
  if (res.statusCode == 200) {
    final sharedPreferences = await SharedPreferences.getInstance();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipePage(id: _recipeID),
        ));
    final snackBar = SnackBar(
      content: Text('Comment Berhasil'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    print(jsonDecode(res.body));
    final snackBar = SnackBar(
      content:
          Text("Pastikan semua data diinput dan pastikan data sudah benar"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _RecipePageState extends State<RecipePage> {
  late Future<RecipeDetail> recipes;
  late Future<List<Recipe>> futureRecipes;
  List<Ingredient> dataIngredients = [];
  List<Tool> dataTools = [];
  List<Steps> dataSteps = [];
  List<Recipe> favRecipes = [];
  String judul = '';
  bool isFavorite = false;

  Future<RecipeDetail> fetchRecipe() async {
    final res =
        await http.get(Uri.parse('${API.BASE_URL}/recipe/${widget.id}'));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var parsedRecipe = data['data_recipe'];
      var parsedIngreds = data['data_ingredients'];
      var parsedTools = data['data_tools'];
      var parsedSteps = data['data_steps'];

      RecipeDetail recipeDetail = RecipeDetail(
          author: data['author']['name'],
          dataRecipe: parsedRecipe['judul'],
          dataIngredients: parsedIngreds
              .map<Ingredient>(
                  (ingredientJson) => Ingredient.fromJson(ingredientJson))
              .toList(),
          dataTools: parsedTools
              .map<Tool>((toolJson) => Tool.fromJson(toolJson))
              .toList(),
          dataSteps: parsedSteps
              .map<Steps>((stepJson) => Steps.fromJson(stepJson))
              .toList());
      print(recipeDetail);
      return recipeDetail;
    } else {
      throw Exception('Failed fetching recipe detail');
    }
  }

  void checkFavorite() {
    for (var map in favRecipes) {
      if (map.id == widget.id) {
        setState(() {
          isFavorite = true;
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    recipes = fetchRecipe();
    futureRecipes = fetchMyRecipe();
    futureRecipes.then((value) {
      favRecipes = value;
    });
    checkFavorite();

    recipes.then((recipeDetail) {
      setState(() {
        dataIngredients = recipeDetail.dataIngredients;
        dataTools = recipeDetail.dataTools;
        dataSteps = recipeDetail.dataSteps;
        judul = recipeDetail.dataRecipe;
        print(recipeDetail.dataRecipe);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          body: TabBarView(
            children: [
              Ingredients(
                ingreds: dataIngredients,
              ),
              Instruction(steps: dataSteps),
              Comments(id: widget.id),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.orange,
                expandedHeight: 200,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${judul}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      // IconButton(
                      //   icon: isFavorite
                      //       ? Icon(
                      //           Icons.favorite_border,
                      //           color: Colors.white,
                      //         )
                      //       : Icon(
                      //           Icons.favorite,
                      //           color: Colors.white,
                      //         ),
                      //   onPressed: isFavorite
                      //       ? () {
                      //           widget.deleteFavorite();
                      //           setState(() {
                      //             isFavorite = false;
                      //           });
                      //         }
                      //       : () async {
                      //           await widget.addFavorite();
                      //           setState(() {
                      //             isFavorite = true;
                      //           });
                      //         },
                      // ),
                      () {
                        for (var map in favRecipes) {
                          if (map.id == widget.id) {
                            isFavorite = true;
                            break;
                          }
                        }
                        if (!isFavorite) {
                          return IconButton(
                            onPressed: () async {
                              await widget.addFavorite();
                            },
                            iconSize: 16,
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return IconButton(
                            onPressed: () {
                              widget.deleteFavorite();
                            },
                            iconSize: 16,
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          );
                        }
                      }(),
                    ],
                  ),
                  background: Image(
                    image: AssetImage('assets/images/kill.jpg'),
                    fit: BoxFit.cover,
                    color: Colors.grey[700]?.withOpacity(0.5),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDeligate(
                  TabBar(
                    indicatorColor: Colors.white,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.orange,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                    tabs: [
                      Tab(
                        text: 'Ingredients',
                      ),
                      Tab(
                        text: 'Instruction',
                      ),
                      Tab(text: 'Comments'),
                    ],
                  ),
                ),
                pinned: true,
              )
            ];
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDeligate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDeligate(this._tabBar);
  final TabBar _tabBar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Ingredients extends StatelessWidget {
  final List<Ingredient> ingreds;

  const Ingredients({Key? key, required this.ingreds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30),
            itemCount: ingreds.length,
            itemBuilder: (BuildContext context, int index) {
              Ingredient ingredient = ingreds[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListTile(
                  leading: const Icon(Icons.list),
                  trailing: Text(
                    '${ingredient.quantity} ${ingredient.unit}',
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text(ingredient.ingredientName),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Instruction extends StatelessWidget {
  final List<Steps> steps;
  const Instruction({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30),
            itemCount: steps.length,
            itemBuilder: (BuildContext context, int index) {
              Steps step = steps[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Text(
                      step.urutan.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  title: Text(step.deskripsi),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Comments extends StatelessWidget {
  var deskripsi = TextEditingController();
  var rating = 0.0;
  final int id;

  Comments({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // kerjain di sini
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/kill.jpg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Write a nice comment...",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RatingBar(
              initialRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                half: Icon(
                  Icons.star_half,
                  color: Colors.orange,
                ),
                empty: Icon(
                  Icons.star_border,
                  color: Colors.orange,
                ),
              ),
              onRatingUpdate: (r) {
                rating = r;
              },
            ),
            // _email, _rating, _recipeID, _deskripsi, BuildContext context
            MaterialButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final email = prefs.getString("email");
                postComment(email, rating, this.id, deskripsi.text, context);
              },
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.orange,
            ),
          ],
        ),
        // listview of comments with circle avatar here
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/kill.jpg'),
                  ),
                  title: Text("Comment $index"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
