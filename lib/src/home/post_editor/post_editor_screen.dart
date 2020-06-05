import 'package:botiblog/src/home/home_screen.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_event.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen_texts.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum EditorType { Add, Edit }

class PostEditorScreen extends StatefulWidget {
  static final String routeName = '${HomeScreen.routeName}/post_editor';
  static final String paramName = 'USER_POST_ARGS';

  @override
  _PostEditorScreenState createState() => _PostEditorScreenState();
}

class _PostEditorScreenState extends State<PostEditorScreen> {
  final _textController = TextEditingController();
  final _publishFocusNode = FocusNode();

  EditorType screenType;
  UserPostResponseModel userPost;
  bool saveEnabled = false;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context).settings.arguments as Map;
    if (args != null) {
      screenType = EditorType.Edit;
      userPost = args[PostEditorScreen.paramName];
      _textController.text = userPost.post.text;
      _updateSaveAvailable();
    } else {
      screenType = EditorType.Add;
    }
    super.didChangeDependencies();
  }

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
            textColor: AppColors.white,
            child: Text(appBarButtonText),
            onPressed: saveEnabled
                ? () {
                    if (screenType == EditorType.Edit) {
                      context
                          .bloc<UserNewsBloc>()
                          .add(UserNewsUpdated(userPost, _textController.text));
                    } else {
                      context
                          .bloc<UserNewsBloc>()
                          .add(UserNewsAdded(_textController.text));
                    }
                  }
                : null,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<UserNewsBloc, UserNewsState>(
          listener: (context, state) {
            if (state is UserNewsLoadFailure) {
              _showDialog('Ops :(', 'Algo deu errado.', 'Ok', () {
                Navigator.of(context).pop();
              });
            }
            if (state is UserNewsLoadSuccess) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is UserNewsLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _buildTextField();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      onChanged: (text) {
        setState(() {
          _updateSaveAvailable();
        });
      },
      controller: _textController,
      focusNode: _publishFocusNode,
      autofocus: true,
      maxLines: null,
      maxLength: 280,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
        border: InputBorder.none,
        isDense: true,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: UserNewsTabTexts.publishHint,
      ),
    );
  }

  void _updateSaveAvailable() {
    saveEnabled = _textController.text.isNotEmpty;
  }

  void _showDialog(String title, String message, String buttonText,
      Function onButtonPressed) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(buttonText),
              onPressed: onButtonPressed,
            ),
          ],
        );
      },
    );
  }
}
