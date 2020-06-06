import 'package:botiblog/src/home/user_news/model/post_model.dart';
import 'package:equatable/equatable.dart';

abstract class BotiNewsState extends Equatable {
  const BotiNewsState();
}

class BotiNewsLoadInProgress extends BotiNewsState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'BotiNewsLoadInProgress{}';
  }
}

class BotiNewsLoadFailure extends BotiNewsState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'BotiNewsLoadFailure{}';
  }
}

class BotiNewsLoadSuccess extends BotiNewsState {
  final List<PostModel> news;

  BotiNewsLoadSuccess(this.news);

  @override
  List<Object> get props => [news];

  @override
  String toString() {
    return 'BotiNewsLoadSuccess{news: $news}';
  }
}

class BotiNewsLoadSuccessEmpty extends BotiNewsState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'BotiNewsLoadSuccessEmpty{}';
  }
}
