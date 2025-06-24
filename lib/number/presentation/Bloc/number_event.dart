import 'package:equatable/equatable.dart';

class NumberEvent extends Equatable {
  const NumberEvent();

  @override
  List<Object> get props => [];
}

class GetNumbersEvent extends NumberEvent {
  const GetNumbersEvent();

  @override
  List<Object> get props => [];
}

class SelectNumber extends NumberEvent {
  final String numberSelected;
  final String numberName;

  const SelectNumber({required this.numberSelected, required this.numberName});

  @override
  List<Object> get props => [numberSelected];
}
