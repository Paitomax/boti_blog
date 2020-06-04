import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:botiblog/src/home/user_news/user_news_repository_interface.dart';
import 'package:botiblog/src/shared/current_datetime/current_date_interface.dart';
import 'package:botiblog/src/shared/formatters/date_formatter.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';

import './bloc.dart';
import 'model/user_post_model.dart';

class UserNewsBloc extends Bloc<UserNewsEvent, UserNewsState> {
  final UserNewsRepositoryInterface userNewsRepository;
  final UserRepositoryInterface userRepository;
  final CurrentDateTimeInterface currentDateTime;

  UserNewsBloc(
      this.userNewsRepository, this.userRepository, this.currentDateTime);

  @override
  UserNewsState get initialState => UserNewsLoadInProgress();

  @override
  Stream<UserNewsState> mapEventToState(
    UserNewsEvent event,
  ) async* {
    if (event is UserNewsAdded) {
      yield* _mapUserNewsAddedToState(event);
    } else if (event is UserNewsRemoved) {
      yield* _mapUserNewsRemovedToState(event);
    } else if (event is UserNewsUpdated) {
      yield* _mapUserNewsUpdatedToState(event);
    } else if (event is UserNewsLoaded) {
      yield* _mapUserNewsLoadedToState(event);
    }
  }

  Stream<UserNewsState> _mapUserNewsAddedToState(UserNewsAdded event) async* {
    try {
      yield UserNewsLoadInProgress();
      final user = await userRepository.get();

      final String date = DateFormatter.toDatabaseFormat(currentDateTime.now());
      final post = UserPostModel(event.text, date, id: user.id);
      final userPost = UserPostResponseModel(post, user);
      await userNewsRepository.add(userPost);

      final posts = await userNewsRepository.fetch(user);
      yield UserNewsLoadSuccess(posts);
    } catch (e) {
      yield UserNewsLoadFailure();
    }
  }

  Stream<UserNewsState> _mapUserNewsRemovedToState(
      UserNewsRemoved event) async* {
    try {
      yield UserNewsLoadInProgress();
      await userNewsRepository.remove(event.userPost.post);

      final user = await userRepository.get();
      final posts = await userNewsRepository.fetch(user);
      yield UserNewsLoadSuccess(posts);
    } catch (e) {
      yield UserNewsLoadFailure();
    }
  }

  Stream<UserNewsState> _mapUserNewsUpdatedToState(
      UserNewsUpdated event) async* {
    try {
      yield UserNewsLoadInProgress();

      final currentDate = DateFormatter.toDatabaseFormat(currentDateTime.now());

      final oldPost = event.userPost.post;
      final newPost = UserPostModel(oldPost.text, currentDate, id: oldPost.id);

      await userNewsRepository.update(newPost);

      final user = await userRepository.get();
      final posts = await userNewsRepository.fetch(user);
      yield UserNewsLoadSuccess(posts);
    } catch (e) {
      yield UserNewsLoadFailure();
    }
  }

  Stream<UserNewsState> _mapUserNewsLoadedToState(UserNewsLoaded event) async* {
    try {
      yield UserNewsLoadInProgress();
      final user = await userRepository.get();
      final posts = await userNewsRepository.fetch(user);
      yield UserNewsLoadSuccess(posts);
    } catch (e) {
      yield UserNewsLoadFailure();
    }
  }
}
