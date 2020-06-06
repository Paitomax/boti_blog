import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadInProgress extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadSuccess extends PostState {
  final bool hadChanges;

  PostLoadSuccess({this.hadChanges = true});

  @override
  List<Object> get props => [];
}

class PostLoadFailure extends PostState {
  @override
  List<Object> get props => [];
}
