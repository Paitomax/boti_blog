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
  ) async* {}
}
