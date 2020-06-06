import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_editor_screen.dart';
import 'package:botiblog/src/home/post_editor/post_event.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_event.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen_texts.dart';
import 'package:botiblog/src/home/user_news/widget/boti_user_post_card.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/shared/widgets/dialog/boti_confirm_dialog.dart';
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
                } else if (state is UserNewsLoadSuccessEmpty) {
                  return _buildEmptyMessage();
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
    return BotiUserPostCard(
      post: item,
      currentUser: user,
      onEditPressed: (UserPostResponseModel item) {
        _navigateToEditor(args: {PostEditorScreen.paramName: item});
      },
      onDeletePressed: (UserPostResponseModel item) {
        showDeleteConfirmationDialog(item);
      },
    );
  }

  void _navigateToEditor({Object args}) async {
    Navigator.of(context)
        .pushNamed(PostEditorScreen.routeName, arguments: args);
  }

  void showDeleteConfirmationDialog(UserPostResponseModel item) {
    BotiConfirmAlertDialog(
      key: Key('BotiConfirmAlertDialogKey'),
      parentContext: context,
      title: UserNewsTabTexts.dialogAttention,
      message: UserNewsTabTexts.dialogHaveSure,
      primaryButtonText: UserNewsTabTexts.dialogYesButtonText,
      secondaryButtonText: UserNewsTabTexts.dialogNoButtonText,
      onPrimaryButtonPressed: () {
        context.bloc<PostBloc>().add(PostRemoved(item));
        Navigator.of(context).pop();
      },
      onSecondaryButtonPressed: () {
        Navigator.of(context).pop();
      },
    ).show();
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

  Widget _buildEmptyMessage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.layers_clear,
            color: AppColors.blue,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            UserNewsTabTexts.emptyMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.orange, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
