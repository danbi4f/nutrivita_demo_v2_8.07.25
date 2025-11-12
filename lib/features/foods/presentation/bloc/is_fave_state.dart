part of 'is_fave_bloc.dart';


class IsFaveState extends Equatable {
  final List<int> faveIds;
  const IsFaveState({required this.faveIds});

  IsFaveState copyWith({List<int>? faveIds}) {
    return IsFaveState(
      faveIds: faveIds ?? this.faveIds,
    );
  }

  @override
  List<Object> get props => [faveIds];
}



