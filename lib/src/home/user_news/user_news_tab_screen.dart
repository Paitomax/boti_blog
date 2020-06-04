import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_event.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_texts.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNewsTab extends StatefulWidget {
  @override
  _UserNewsTabState createState() => _UserNewsTabState();
}

class _UserNewsTabState extends State<UserNewsTab> {
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
            Form(
              child: TextField(
                maxLength: 280,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  hintText: UserNewsTabTexts.publishHint,
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
            BlocBuilder<UserNewsBloc, UserNewsState>(
              builder: (context, state) {
                if (state is UserNewsLoadSuccess) {
                  return Column(
                    children: <Widget>[
                      BotiFlatButton(
                        text: UserNewsTabTexts.publishButton,
                        onPressed: () {},
                      ),
                      SizedBox(height: 8),
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
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
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(item.post.text,
                  style: TextStyle(color: AppColors.lightOrange)),
            ),
            SizedBox(height: 4),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    DateFormatter.format(item.post.getDateTime),
                    style: TextStyle(fontSize: 12, color: Color(0xFFBABABA)),
                  ),
                )),
          ],
        ),
      ),
    );
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
                context.bloc<UserNewsBloc>().add(UserNewsRemoved(item));
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
}
