import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:flutter/material.dart';

class BotiUserPostCard extends StatelessWidget {
  final PostModel post;
  final UserModel currentUser;
  final Function(PostModel) onEditPressed;
  final Function(PostModel) onDeletePressed;

  const BotiUserPostCard({
    Key key,
    this.post,
    this.currentUser,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          SizedBox(height: 4),
          _buildContent(),
          SizedBox(height: 4),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          _buildName(),
          _buildIconButton(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16.0),
      child: _buildMessage(),
    );
  }

  Widget _buildFooter() {
    final double padding = post.isAuthor(currentUser) ? 0 : 16;

    return Padding(
      padding: EdgeInsets.only(right: 16.0, top: padding, bottom: padding),
      child: Row(
        children: <Widget>[
          _buildEditButton(),
          _buildDate(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(post.user.name,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blue)),
      ),
    );
  }

  Widget _buildIconButton() {
    return Visibility(
      visible: post.isAuthor(currentUser),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.close, size: 12, color: Colors.red),
        ),
        onTap: () => onDeletePressed(post),
      ),
    );
  }

  Widget _buildMessage() {
    return Text(
      post.post.text,
      style: TextStyle(
        color: AppColors.lightOrange,
      ),
    );
  }

  Widget _buildEditButton() {
    return Visibility(
      visible: post.isAuthor(currentUser),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.edit, size: 12, color: AppColors.orange),
        ),
        onTap: () => onEditPressed(post),
      ),
    );
  }

  Widget _buildDate() {
    return Expanded(
      child: Text(
        DateFormatter.format(post.post.date),
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFFBABABA),
        ),
      ),
    );
  }
}
