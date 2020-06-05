import 'package:equatable/equatable.dart';

abstract class BotiNewsEvent extends Equatable {
  const BotiNewsEvent();
}

class BotiNewsLoaded extends BotiNewsEvent {
  @override
  List<Object> get props => [];
}
