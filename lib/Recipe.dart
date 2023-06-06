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

// class _RecipeState extends State<Recipe> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             toolbarHeight: 180,
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   text: 'FIRST',
//                 ),
//                 Tab(
//                   text: 'SECOND',
//                 ),
//                 Tab(text: 'THIRD'),
//               ],
//             ),
//             title: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 200,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/kill.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               Ingredients(),
//               Instruction(),
//               Comments(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _RecipeState extends State<Recipe> {
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
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDeligate(
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Expanded(
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: const Text(
                      "GFG",
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("List item $index"));
              }),
        ));
  }
}

class Instruction extends StatelessWidget {
  const Instruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // kerjain di sini
    return Text("Instruction");
  }
}

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // kerjain di sini
    return Text("Comments");
  }
}
