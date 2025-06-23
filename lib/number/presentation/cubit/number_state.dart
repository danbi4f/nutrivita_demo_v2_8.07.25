part of 'number_cubit.dart';

sealed class NumberState extends Equatable {
  const NumberState();

  @override
  List<Object> get props => [];
}

final class NumberInitial extends NumberState {}

class NumberLoading extends NumberState {}

final class NumberLoaded extends NumberState {
  final List<Number> numbers;

  const NumberLoaded(this.numbers);

  @override
  List<Object> get props => [numbers];
}

final class NumberError extends NumberState {
  final String message;

  const NumberError(this.message);

  @override
  List<Object> get props => [message];
}
