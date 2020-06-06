import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/home/post_editor/post_event.dart';
import 'package:botiblog/src/home/post_editor/post_repository_interface.dart';
import 'package:botiblog/src/home/post_editor/post_state.dart';
import 'package:botiblog/src/home/user_news/model/post_message_model.dart';
import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:botiblog/src/shared/current_datetime/current_date_interface.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepositoryInterface userNewsRepository;
  final UserRepositoryInterface userRepository;
  final CurrentDateTimeInterface currentDateTime;

  PostBloc(this.userNewsRepository, this.userRepository, this.currentDateTime);

  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostAdded) {
      yield* _mapPostEditorAddedToState(event);
    } else if (event is PostRemoved) {
      yield* _mapPostEditorRemovedToState(event);
    } else if (event is PostUpdated) {
      yield* _mapPostEditorUpdatedToState(event);
    }
  }

  Stream<PostState> _mapPostEditorAddedToState(PostAdded event) async* {
    try {
      yield PostLoadInProgress();
      final user = await userRepository.get();

      final post =
          PostMessageModel(event.text, currentDateTime.now(), id: user.id);
      final userPost = PostModel(post, user);

      await userNewsRepository.add(userPost);

      yield PostLoadSuccess();
    } catch (e) {
      yield PostLoadFailure();
    }
  }

  Stream<PostState> _mapPostEditorRemovedToState(PostRemoved event) async* {
    try {
      yield PostLoadInProgress();
      await userNewsRepository.remove(event.userPost.post);
      yield PostLoadSuccess();
    } catch (e) {
      yield PostLoadFailure();
    }
  }

  Stream<PostState> _mapPostEditorUpdatedToState(PostUpdated event) async* {
    try {
      yield PostLoadInProgress();
      bool hadChanges = true;
      if (event.userPost.post.text == event.newText) {
        hadChanges = false;
      } else {
        final oldPost = event.userPost.post;
        final newPost = PostMessageModel(event.newText, currentDateTime.now(),
            id: oldPost.id);

        await userNewsRepository.update(newPost);
      }
      yield PostLoadSuccess(hadChanges: hadChanges);
    } catch (e) {
      yield PostLoadFailure();
    }
  }
}
