import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:botiblog/src/home/boti_news/boti_news_repository_interface.dart';

import './bloc.dart';

class BotiNewsBloc extends Bloc<BotiNewsEvent, BotiNewsState> {
  final BotiNewsRepositoryInterface botiNewsRepository;

  BotiNewsBloc(this.botiNewsRepository);

  @override
  BotiNewsState get initialState => BotiNewsLoadInProgress();

  @override
  Stream<BotiNewsState> mapEventToState(
    BotiNewsEvent event,
  ) async* {
    if (event is BotiNewsLoaded) {
      yield* _mapBotiNewsLoadedToState(event);
    }
  }

  Stream<BotiNewsState> _mapBotiNewsLoadedToState(BotiNewsLoaded event) async* {
    try {
      yield BotiNewsLoadInProgress();
      final response = await botiNewsRepository.fetch();
      yield BotiNewsLoadSuccess(response.news);
    } catch (e) {
      yield BotiNewsLoadFailure();
    }
  }
}
