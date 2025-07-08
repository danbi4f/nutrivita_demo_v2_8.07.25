part of 'number_bloc.dart';

class NumbersState extends Equatable {
  const NumbersState({
    this.numbers = const [],
    this.numberSelected = const Number.empty(),
    this.delayedResult = const DelayedResult.idle(),
  });

  final List<Number> numbers;
  final Number numberSelected;
  final DelayedResult<String> delayedResult;

  NumbersState copyWith({
    List<Number>? numbers,
    Number? numberSelected,
    DelayedResult<String>? delayedResult,
    List<Number>? allNumbers,
  }) {
    return NumbersState(
      numbers: numbers ?? this.numbers,
      numberSelected: numberSelected ?? this.numberSelected,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object> get props => [numbers, numberSelected, delayedResult];
}
