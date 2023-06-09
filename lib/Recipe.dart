// TODO: TabBar still nembus content

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const RecipePage());
}

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          body: TabBarView(
            children: [
              Ingredients(),
              Instruction(),
              Comments(),
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
                  title: Text(
                    "Recipe Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
  const Ingredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // kerjain di sini
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListTile(
                  leading: const Icon(Icons.list),
                  trailing: const Text(
                    "GFG",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text("List item $index"),
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
  const Instruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // kerjain di sini
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30),
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "${index + 1}. List instruction $index",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

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
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            MaterialButton(
              onPressed: () {},
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
