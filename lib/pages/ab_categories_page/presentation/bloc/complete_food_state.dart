part of 'complete_food_bloc.dart';

class CompleteFoodState extends Equatable {
  final DelayedResult<CompleteFood?> completeFood;

  const CompleteFoodState({
    this.completeFood = const DelayedResult.idle(),
  });

  CompleteFoodState copyWith({
    DelayedResult<CompleteFood?>? completeFood,
  }) {
    return CompleteFoodState(
      completeFood: completeFood ?? this.completeFood,
    );
  }

  @override
  List<Object?> get props => [completeFood];
}