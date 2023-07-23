import 'package:flutter/material.dart';
import 'package:qrify_me/default/login_page.dart';
import 'package:qrify_me/default/register_page.dart';
import 'home_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currIndex = 0;

  void onTappedItem(int index) {
    setState(() {
      currIndex = index;
    });
  }

  List<Widget> pages = const <Widget>[HomePage(), RegisterPage(), LoginPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login_rounded),
            label: 'Login',
          )
        ],
        currentIndex: currIndex,
        onTap: onTappedItem,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
