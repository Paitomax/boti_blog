import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class UserNewsBloc extends Bloc<UserNewsEvent, UserNewsState> {
  @override
  UserNewsState get initialState => UserNewsLoadInProgress();

  @override
  Stream<UserNewsState> mapEventToState(
    UserNewsEvent event,
  ) async* {}
}
