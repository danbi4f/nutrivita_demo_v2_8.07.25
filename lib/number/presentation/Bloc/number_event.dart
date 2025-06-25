import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';

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
  final Number numberSelected;

  const SelectNumber({required this.numberSelected});

  @override
  List<Object> get props => [numberSelected];
}
