import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_repository_interface.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';

import './bloc.dart';

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

  Stream<UserNewsState> _mapUserNewsAddedToState(UserNewsAdded event) async* {}

  Stream<UserNewsState> _mapUserNewsRemovedToState(
      UserNewsRemoved event) async* {}

  Stream<UserNewsState> _mapUserNewsUpdatedToState(
      UserNewsUpdated event) async* {}

  Stream<UserNewsState> _mapUserNewsLoadedToState(
      UserNewsLoaded event) async* {}
}
