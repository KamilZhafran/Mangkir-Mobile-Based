import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tubes_app/Home.dart';
import 'package:tubes_app/Login.dart';

import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello, World!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNav(),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  int selected = 0;
  PageController pc = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      // ),
      body: SafeArea(
        child: PageView(
          controller: pc,
          onPageChanged: (value) {
            setState(() {
              selected = value;
            });
          },
          children: [
            HomePage(),
            Container(
              child: Text('Upload'),
            ),
            Container(
              child: Text('Favorite'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: const Color(0x7d7d7d7d),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selected,
        onTap: (value) {
          setState(() {
            selected = value;
            pc.animateToPage(value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn);
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
