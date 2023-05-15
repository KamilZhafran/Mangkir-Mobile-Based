import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const Home());
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
  int selected = 0;
  PageController pc = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: PageView(
          controller: pc,
          onPageChanged: (value) {
            setState(() {
              selected = value;
            });
          },
          children: [
            Container(
              child: Text('Home'),
            ),
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
            icon: new SvgPicture.asset('assets/images/ic_round-home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new SvgPicture.asset('assets/images/ic_cloud-upload.svg'),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: new SvgPicture.asset('assets/images/ic_cards-heart.svg'),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
