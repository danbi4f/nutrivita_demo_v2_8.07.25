part of 'is_fave_bloc.dart';

class IsFaveState extends Equatable {
  const IsFaveState({
    required this.food,
    required this.isFave,
    required this.checkoutResult,
  });

  final CompleteFood food;
  final bool isFave;
  final DelayedResult<bool> checkoutResult;

  IsFaveState copyWith({
    CompleteFood? food,
    bool? isFave,
    DelayedResult<bool>? checkoutResult,
  }) {
    return IsFaveState(
      food: food ?? this.food,
      isFave: isFave ?? this.isFave,
      checkoutResult: checkoutResult ?? this.checkoutResult,
    );
  }

  @override
  List<Object> get props => [food, isFave, checkoutResult];
}
