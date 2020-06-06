import 'package:botiblog/src/home/boti_news/boti_news_tab_screen_texts.dart';
import 'package:botiblog/src/home/boti_news/model/boti_news_model.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
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
            Text(
              BotiNewsTabTexts.introduceMessage,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),
            BlocBuilder<BotiNewsBloc, BotiNewsState>(
              builder: (context, state) {
                if (state is BotiNewsLoadSuccess) {
                  return _buildPostList(state.news);
                } else if (state is BotiNewsLoadSuccessEmpty) {
                  return _buildEmptyMessage();
                } else if (state is BotiNewsLoadFailure) {
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

  Widget _buildPostList(List<BotiNewsModel> news) {
    return ListView.builder(
      itemCount: news.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (listViewContext, index) {
        final item = news[index];
        return _buildCard(item);
      },
    );
  }

  Widget _buildCard(BotiNewsModel item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(item.user.name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue)),
            SizedBox(height: 4),
            Text(item.message.content,
                style: TextStyle(color: AppColors.lightOrange)),
            SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormatter.format(item.message.createdAt),
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFBABABA),
                ),
              ),
            ),
          ],
        ),
      ),
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
}
