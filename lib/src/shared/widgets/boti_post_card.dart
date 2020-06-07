import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:flutter/material.dart';

class BotiPostCard extends StatelessWidget {
  final PostModel post;
  final UserModel currentUser;
  final Function(PostModel) onEditPressed;
  final Function(PostModel) onDeletePressed;

  const BotiPostCard({
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
          _buildHeader(context),
          SizedBox(height: 4),
          _buildContent(context),
          SizedBox(height: 4),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: <Widget>[
          _buildName(context),
          _buildDeleteButton(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16.0),
      child: _buildMessage(context),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final double padding = _isAuthor() ? 0 : 16;

    return Padding(
      padding: EdgeInsets.only(right: 16.0, top: padding, bottom: padding),
      child: Row(
        children: <Widget>[
          _buildEditButton(context),
          _buildDate(context),
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            post.user.name,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Theme.of(context).colorScheme.primary),
          )),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Visibility(
      visible: _isAuthor(),
      child: InkWell(
        key: Key("${key.toString()}Delete"),
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.close, size: 12, color: Colors.red),
        ),
        onTap: () => onDeletePressed(post),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      post.post.text,
      style: TextStyle(),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Visibility(
      visible: _isAuthor(),
      child: InkWell(
        key: Key("${key.toString()}Edit"),
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(Icons.edit,
              size: 12, color: Theme.of(context).colorScheme.secondaryVariant),
        ),
        onTap: () => onEditPressed(post),
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    return Expanded(
      child: Text(
        DateFormatter.format(post.post.date),
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  bool _isAuthor() {
    if (currentUser == null) return false;
    return post.isAuthor(currentUser);
  }
}
