import 'package:botiblog/src/home/boti_news/boti_news_tab_screen_texts.dart';
import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/home/widget/post_list_view.dart';
import 'package:botiblog/src/shared/widgets/boti_empty_message.dart';
import 'package:botiblog/src/shared/widgets/boti_error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class BotiNewsTabScreen extends StatefulWidget {
  @override
  _BotiNewsTabScreenState createState() => _BotiNewsTabScreenState();
}

class _BotiNewsTabScreenState extends State<BotiNewsTabScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<BotiNewsBloc>().add(BotiNewsLoaded());
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
            Divider(),
            SizedBox(height: 16),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduceMessage() {
    return Text(
      BotiNewsTabTexts.introduceMessage,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildContent() {
    return BlocBuilder<BotiNewsBloc, BotiNewsState>(
      builder: (context, state) {
        if (state is BotiNewsLoadSuccess) {
          return _buildPostList(state.news);
        } else if (state is BotiNewsLoadSuccessEmpty) {
          return _buildEmptyMessage();
        } else if (state is BotiNewsLoadFailure) {
          return _buildErrorMessage();
        } else {
          return _buildProgressIndicator();
        }
      },
    );
  }

  Widget _buildPostList(List<PostModel> posts) {
    return PostListView(
      key: Key(BotiNewsTabTexts.postListViewKey),
      posts: posts,
    );
  }

  Widget _buildErrorMessage() {
    return BotiErrorMessage(
      key: Key(BotiNewsTabTexts.errorMessageKey),
      errorMessage: BotiNewsTabTexts.errorMessage,
      actionText: BotiNewsTabTexts.loadScreen,
      onPressed: () {
        context.bloc<BotiNewsBloc>().add(BotiNewsLoaded());
      },
    );
  }

  Widget _buildEmptyMessage() {
    return BotiEmptyMessage(
      key: Key(BotiNewsTabTexts.emptyMessageKey),
      message: BotiNewsTabTexts.emptyMessage,
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: CircularProgressIndicator(),
    );
  }
}
