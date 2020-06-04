import 'package:botiblog/src/home/user_news/user_news_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  List<Widget> _tabs = [UserNewsTab(), UserNewsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_tabIndex],
      appBar: AppBar(title: Text('Boti Blog'),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: _onTabPressed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Boti News'),
          ),
        ],
      ),
    );
  }

  void _onTabPressed(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
