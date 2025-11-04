part of 'complete_food_bloc.dart';



sealed class CompleteFoodEvent extends Equatable {
  const CompleteFoodEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCompleteFoodByFdcId extends CompleteFoodEvent {
  const LoadCompleteFoodByFdcId(this.fdcId);

  final int fdcId;
}
