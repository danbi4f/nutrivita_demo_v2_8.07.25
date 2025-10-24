part of 'food_bloc.dart';

 class FoodState extends Equatable {
    final List<CompleteFood> foods;
  final DelayedResult<void> loadingResult;

  
  const FoodState({
    this.loadingResult = const DelayedResult.idle(),
    this.foods = const [],

  });

    FoodState copyWith({
    List<CompleteFood>? foods,
    DelayedResult<void>? loadingResult,

  }) {
    return FoodState(
      foods: foods ?? this.foods,
      loadingResult: loadingResult ?? this.loadingResult,

    );
  }
  
  @override
  List<Object> get props => [foods, loadingResult];
}


