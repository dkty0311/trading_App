import 'package:flutter/material.dart';
import 'package:login_page_1/ui/screens/first.dart';
import 'package:login_page_1/ui/screens/myPage.dart';
import 'package:login_page_1/ui/screens/Second.dart';
import 'package:login_page_1/ui/screens/Search.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart'; // flutter_secure_storage 패키지

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.controller}) : super(key: key);
  final PageController controller;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Widget> pages = <Widget>[myPage(), first(), Second(), Search()];

  int _selectedIndex = 0;
  String? sessionValue;
  String indexValue = '';
  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    //네비게이션바 인덱스
    setState(() {
      _selectedIndex = index;
    });
  }

//로그아웃처리
  logout() async {
    await storage.delete(key: 'login');
    widget.controller.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Intercept',
          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
        ),
        backgroundColor: Color(0xFF755DC1),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout();
              })
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff6200ee),
        unselectedItemColor: const Color(0xff757575),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("홈"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite_border),
    title: const Text("찜한목록"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("검색"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("마이페이지"),
    selectedColor: Colors.teal,
  ),
];
