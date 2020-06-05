import 'package:botiblog/src/home/user_news/model/user_post_model.dart';
import 'package:botiblog/src/home/user_news/model/user_post_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserNewsEvent extends Equatable {
  const UserNewsEvent();
}

class UserNewsLoaded extends UserNewsEvent {
  @override
  List<Object> get props => [];
}
