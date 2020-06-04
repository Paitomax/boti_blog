import 'package:botiblog/src/home/user_news/user_news_tab_screen.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  List<Widget> _tabs = [UserNewsTabScreen(), UserNewsTabScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_tabIndex],
      appBar: AppBar(
        title: Text('Boti Blog'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _menuPopUpSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 1, child: Text('Sair')),
              ];
            },
          )
        ],
      ),
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

  void _menuPopUpSelected(int index) {
    if (index == 1) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          SignInScreen.routeName, (route) => false);
    }
  }
}
