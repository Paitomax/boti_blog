import 'package:equatable/equatable.dart';

abstract class UserNewsEvent extends Equatable {
  const UserNewsEvent();
}

class UserNewsLoaded extends UserNewsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'UserNewsLoaded{}';
  }
}
