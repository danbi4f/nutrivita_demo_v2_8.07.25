part of 'fave_bloc.dart';

sealed class FaveEvent extends Equatable {
  const FaveEvent();
  @override
  List<Object?> get props => [];
}

class LoadFaves extends FaveEvent {
  const LoadFaves();
}

class AddFave extends FaveEvent {
  final int fdcId;
  const AddFave(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}

class RemoveFave extends FaveEvent {
  final int fdcId;
  const RemoveFave(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}


final class ClearError extends FaveEvent {
  const ClearError();
}