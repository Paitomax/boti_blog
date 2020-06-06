import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BotiNewsCard extends StatelessWidget {
  final PostModel botiNews;

  const BotiNewsCard({
    Key key,
    this.botiNews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildName(botiNews.user.name),
            SizedBox(height: 4),
            _buildMessage(botiNews.post.text),
            SizedBox(height: 4),
            _buildDate(botiNews.post.date),
          ],
        ),
      ),
    );
  }

  Widget _buildName(String name) {
    return Text(name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.blue,
        ));
  }

  Widget _buildMessage(String message) {
    return Text(
      message,
      style: TextStyle(
        color: AppColors.lightOrange,
      ),
    );
  }

  Widget _buildDate(DateTime date) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        DateFormatter.format(date),
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.gray,
        ),
      ),
    );
  }
}
