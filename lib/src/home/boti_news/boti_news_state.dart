import 'package:botiblog/src/home/boti_news/model/boti_news_model.dart';
import 'package:equatable/equatable.dart';

abstract class BotiNewsState extends Equatable {
  const BotiNewsState();
}

class BotiNewsLoadInProgress extends BotiNewsState {
  @override
  List<Object> get props => [];
}

class BotiNewsLoadFailure extends BotiNewsState {
  @override
  List<Object> get props => [];
}

class BotiNewsLoadSuccess extends BotiNewsState {
  final List<BotiNewsModel> news;

  BotiNewsLoadSuccess(this.news);

  @override
  List<Object> get props => [news];
}

class BotiNewsLoadSuccessEmpty extends BotiNewsState {
  @override
  List<Object> get props => [];
}
