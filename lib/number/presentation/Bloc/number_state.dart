part of 'number_bloc.dart';

sealed class NumberState extends Equatable {
  const NumberState();

  @override
  List<Object> get props => [];
}

final class NumberInitial extends NumberState {}

class NumberLoading extends NumberState {}

final class NumberLoaded extends NumberState {
  const NumberLoaded({
    List<Number>? numbers,
    this.numberSelected = '0',
    this.numberName = '',
  }) : numbers = numbers ?? const [];

  final List<Number> numbers;
  final String numberSelected;
  final String numberName;

  @override
  List<Object> get props => [numbers, numberSelected];

  NumberLoaded copyWith({
    List<Number>? numbers,
    String? numberSelected,
    String? numberName,
  }) {
    return NumberLoaded(
      numbers: numbers ?? this.numbers,
      numberSelected: numberSelected ?? this.numberSelected,
      numberName: numberName ?? this.numberName,
    );
  }
}

final class NumberError extends NumberState {
  final String message;

  const NumberError(this.message);

  @override
  List<Object> get props => [message];
}
