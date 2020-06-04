import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Estou na home galereeee, até que enfim'),
      ),
    );
  }
}
