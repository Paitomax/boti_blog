import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_editor_screen.dart';
import 'package:botiblog/src/home/post_editor/post_event.dart';
import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_event.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_screen_texts.dart';
import 'package:botiblog/src/home/widget/post_list_view.dart';
import 'package:botiblog/src/shared/consts/app_limits.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/shared/widgets/boti_empty_message.dart';
import 'package:botiblog/src/shared/widgets/boti_error_message.dart';
import 'package:botiblog/src/shared/widgets/buttons/boti_rounded_outlined_button.dart';
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
            _buildIntroduceMessage(),
            SizedBox(height: 24),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduceMessage() {
    return Text(
      UserNewsTabTexts.introduceMessage,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<UserNewsBloc, UserNewsState>(
      builder: (context, state) {
        Widget content;
        if (state is UserNewsLoadSuccess) {
          content = Column(
            children: <Widget>[
              _buildWhatAreYouThinkingButton(),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              _buildPostList(state.posts, state.user),
            ],
          );
        } else if (state is UserNewsLoadSuccessEmpty) {
          content = Column(
            children: <Widget>[
              _buildWhatAreYouThinkingButton(),
              SizedBox(height: 16),
              _buildEmptyMessage(),
            ],
          );
        } else if (state is UserNewsLoadFailure) {
          content = _buildErrorMessage();
        } else {
          content = _buildProgressIndicator();
        }

        return AnimatedSwitcher(
          duration:
              Duration(milliseconds: AppLimits.transitionTimeInMilliseconds),
          child: content,
        );
      },
    );
  }

  Widget _buildPostList(List<PostModel> posts, UserModel user) {
    return PostListView(
      key: Key(UserNewsTabTexts.postListViewKey),
      posts: posts,
      user: user,
      onEditPressed: (PostModel item) {
        _navigateToEditor(args: {PostEditorScreen.paramName: item});
      },
      onDeletePressed: (PostModel item) {
        showDeleteConfirmationDialog(item);
      },
    );
  }

  void _navigateToEditor({Object args}) async {
    Navigator.of(context)
        .pushNamed(PostEditorScreen.routeName, arguments: args);
  }

  void showDeleteConfirmationDialog(PostModel item) {
    BotiConfirmAlertDialog(
      key: Key(UserNewsTabTexts.botiConfirmAlertDialogKey),
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
    return BotiErrorMessage(
      errorMessage: UserNewsTabTexts.errorMessage,
      actionText: UserNewsTabTexts.loadScreen,
      onPressed: () {
        context.bloc<UserNewsBloc>().add(UserNewsLoaded());
      },
    );
  }

  Widget _buildWhatAreYouThinkingButton() {
    return BotiRoundedOutlinedButton(
      key: Key(UserNewsTabTexts.newPostButtonKey),
      text: UserNewsTabTexts.publishHint,
      onPressed: () {
        _navigateToEditor();
      },
    );
  }

  Widget _buildEmptyMessage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BotiEmptyMessage(message: UserNewsTabTexts.emptyMessage),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: CircularProgressIndicator(),
    );
  }
}
