import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/shared/user/user_model.dart';
import 'package:botiblog/src/shared/widgets/boti_post_card.dart';
import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {
  final List<PostModel> posts;
  final UserModel user;
  final Function(PostModel) onEditPressed;
  final Function(PostModel) onDeletePressed;

  const PostListView(
      {Key key,
      this.posts,
      this.user,
      this.onEditPressed,
      this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (listViewContext, index) {
        final item = posts[index];
        return _buildCard(item, user, index);
      },
    );
  }

  Widget _buildCard(PostModel item, UserModel user, int index) {
    return BotiPostCard(
      key: Key('BotiPostCardKeyIndex$index'),
      post: item,
      currentUser: user,
      onEditPressed: onEditPressed,
      onDeletePressed: onDeletePressed,
    );
  }
}
