import 'package:botiblog/src/home/home_screen.dart';
import 'package:flutter/material.dart';

enum EditorType { Add, Edit }

class PostEditorScreen extends StatefulWidget {
  static final String routeName = '${HomeScreen.routeName}/post_editor';

  @override
  _PostEditorScreenState createState() => _PostEditorScreenState();
}

class _PostEditorScreenState extends State<PostEditorScreen> {
  EditorType screenType;

  @override
  Widget build(BuildContext context) {
    String title =
        screenType == EditorType.Add ? 'Criar publicação' : 'Editar Publicação';

    String appBarButtonText =
        screenType == EditorType.Add ? 'Publicar' : 'Salvar';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          FlatButton(
            child: Text(appBarButtonText),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
