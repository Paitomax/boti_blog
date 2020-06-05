import 'package:botiblog/src/home/boti_news/boti_news_tab_screen.dart';
import 'package:botiblog/src/home/home_screen_texts.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen.dart';
import 'package:botiblog/src/shared/auth/auth_bloc.dart';
import 'package:botiblog/src/shared/auth/auth_event.dart';
import 'package:botiblog/src/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _MENU_LOGOUT_VALUE = 1;

  int _tabIndex = 0;
  List<Widget> _tabs = [UserNewsTabScreen(), BotiNewsTabScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_tabIndex],
      appBar: AppBar(
        title: Text(HomeScreenTexts.title),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _menuPopUpSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    value: _MENU_LOGOUT_VALUE,
                    child: Text(HomeScreenTexts.logout)),
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
            title: Text(HomeScreenTexts.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text(HomeScreenTexts.botiNews),
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
    if (index == _MENU_LOGOUT_VALUE) {
      BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
    }
  }
}
