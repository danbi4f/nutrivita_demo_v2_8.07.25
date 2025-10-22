part of 'fave_bloc.dart';

abstract class FaveEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFaves extends FaveEvent {}

class AddFave extends FaveEvent {
  final int fdcId;
  AddFave(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}

class RemoveFave extends FaveEvent {
  final int fdcId;
  RemoveFave(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}

