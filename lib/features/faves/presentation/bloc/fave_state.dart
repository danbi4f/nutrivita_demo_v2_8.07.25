part of 'fave_bloc.dart';

class FaveState extends Equatable {
  final List<int> faves;
  final DelayedResult<void> loadingResult;
  final List<Food> foods;

  const FaveState({
    required this.faves,
    required this.loadingResult,
    required this.foods,

  });

  FaveState copyWith({
    List<int>? faves,
    DelayedResult<void>? loadingResult,
    List<Food>? foods,
  }) {
    return FaveState(
      faves: faves ?? this.faves,
      loadingResult: loadingResult ?? this.loadingResult,
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object?> get props => [faves, loadingResult, foods];
}
