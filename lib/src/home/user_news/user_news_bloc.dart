import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_repository_interface.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';

import './bloc.dart';
import 'model/user_post_model.dart';

class UserNewsBloc extends Bloc<UserNewsEvent, UserNewsState> {
  final UserNewsRepositoryInterface userNewsRepository;
  final UserRepositoryInterface userRepository;

  UserNewsBloc(this.userNewsRepository, this.userRepository);

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

      final String date = '2020-02-02T16:00:00Z';
      final post = UserPostModel(user.id, event.text, date);
      await userNewsRepository.add(post);

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
      await userNewsRepository.remove(event.userPost);

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
      await userNewsRepository.update(event.userPost);

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
