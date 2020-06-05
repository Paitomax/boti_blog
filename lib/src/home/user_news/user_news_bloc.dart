import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/home/post_editor/post_bloc.dart';
import 'package:botiblog/src/home/post_editor/post_repository_interface.dart';
import 'package:botiblog/src/home/post_editor/post_state.dart';
import 'package:botiblog/src/shared/current_datetime/current_date_interface.dart';
import 'package:botiblog/src/shared/user/user_repository_interface.dart';

import './bloc.dart';

class UserNewsBloc extends Bloc<UserNewsEvent, UserNewsState> {
  final PostRepositoryInterface postRepository;
  final UserRepositoryInterface userRepository;
  final CurrentDateTimeInterface currentDateTime;
  final PostBloc postBloc;
  StreamSubscription _streamSubscription;

  UserNewsBloc(this.postBloc, this.postRepository, this.userRepository,
      this.currentDateTime) {
    _streamSubscription = postBloc.listen((state) {
      if (state is PostLoadSuccess) add(UserNewsLoaded());
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  @override
  UserNewsState get initialState => UserNewsLoadInProgress();

  @override
  Stream<UserNewsState> mapEventToState(
    UserNewsEvent event,
  ) async* {
    if (event is UserNewsLoaded) {
      yield* _mapUserNewsLoadedToState(event);
    }
  }

  Stream<UserNewsState> _mapUserNewsLoadedToState(UserNewsLoaded event) async* {
    try {
      yield UserNewsLoadInProgress();
      final user = await userRepository.get();
      final posts = await postRepository.fetch(user);
      if (posts.isEmpty) {
        yield UserNewsLoadSuccessEmpty();
      } else {
        yield UserNewsLoadSuccess(posts, user);
      }
    } catch (e) {
      yield UserNewsLoadFailure();
    }
  }
}
