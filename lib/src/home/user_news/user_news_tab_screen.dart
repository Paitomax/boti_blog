import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_editor_screen.dart';
import 'package:botiblog/src/home/post_editor/post_event.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_event.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen_texts.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNewsTabScreen extends StatefulWidget {
  @override
  _UserNewsTabScreenState createState() => _UserNewsTabScreenState();
}

class _UserNewsTabScreenState extends State<UserNewsTabScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<UserNewsBloc>().add(UserNewsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              UserNewsTabTexts.introduceMessage,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            BlocBuilder<UserNewsBloc, UserNewsState>(
              builder: (context, state) {
                if (state is UserNewsLoadSuccess) {
                  return Column(
                    children: <Widget>[
                      _buildWhatAreYouThinkingButton(),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      _buildPostList(state.posts, state.user),
                    ],
                  );
                } else if (state is UserNewsLoadFailure) {
                  return _buildErrorMessage();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPostList(List<UserPostResponseModel> posts, UserModel user) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (listViewContext, index) {
        final item = posts[index];
        return _buildCard(item, user);
      },
    );
  }

  Widget _buildCard(UserPostResponseModel item, UserModel user) {
    final double padding = item.isAuthor(user) ? 0 : 16;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(item.user.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue)),
                  ),
                ),
                Visibility(
                  visible: item.isAuthor(user),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.close, size: 12, color: Colors.red),
                    ),
                    onTap: () {
                      showDeleteConfirmationDialog(item);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: Text(item.post.text,
                style: TextStyle(color: AppColors.lightOrange)),
          ),
          SizedBox(height: 4),
          Padding(
            padding:
                EdgeInsets.only(right: 16.0, top: padding, bottom: padding),
            child: Row(
              children: <Widget>[
                Visibility(
                  visible: item.isAuthor(user),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          Icon(Icons.edit, size: 12, color: AppColors.orange),
                    ),
                    onTap: () {
                      _navigateToEditor(
                          args: {PostEditorScreen.paramName: item});
                    },
                  ),
                ),
                Expanded(
                    child: Text(
                  DateFormatter.format(item.post.date),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFBABABA),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEditor({Object args}) async {
    Navigator.of(context)
        .pushNamed(PostEditorScreen.routeName, arguments: args);
  }

  void showDeleteConfirmationDialog(UserPostResponseModel item) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(UserNewsTabTexts.dialogAttention),
          content: Text(UserNewsTabTexts.dialogHaveSure),
          actions: <Widget>[
            FlatButton(
              child: Text(UserNewsTabTexts.dialogYesButtonText),
              onPressed: () {
                context.bloc<PostBloc>().add(PostRemoved(item));
                Navigator.of(dialogContext).pop();
              },
            ),
            FlatButton(
              child: Text(
                UserNewsTabTexts.dialogNoButtonText,
                style: TextStyle(color: AppColors.lightOrange),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildErrorMessage() {
    return Column(
      children: <Widget>[
        Icon(
          Icons.error,
          color: AppColors.lightOrange,
          size: 32,
        ),
        SizedBox(height: 8),
        Text(
          UserNewsTabTexts.errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          textColor: AppColors.blue,
          child: Text(
            UserNewsTabTexts.loadScreen,
            style: TextStyle(color: AppColors.blue),
          ),
          onPressed: () {
            context.bloc<UserNewsBloc>().add(UserNewsLoaded());
          },
        ),
      ],
    );
  }

  Widget _buildWhatAreYouThinkingButton() {
    return Container(
      width: double.infinity,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: BorderSide(color: Color(0xFFAAAAAA)),
        ),
        hoverColor: Color(0xFFBABABA),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFAAAAAA)),
              borderRadius: BorderRadius.circular(32)),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Text(
            UserNewsTabTexts.publishHint,
            style: TextStyle(
              color: Color(0xFFBABABA),
            ),
          ),
        ),
        onTap: () {
          _navigateToEditor();
        },
      ),
    );
  }
}
