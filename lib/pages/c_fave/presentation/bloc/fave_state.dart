part of 'fave_bloc.dart';

class FaveState extends Equatable {
  final List<int> faves;
  final DelayedResult<void> loadingResult;

  const FaveState({
    required this.faves,
    required this.loadingResult,
  });

  FaveState copyWith({
    List<int>? faves,
    DelayedResult<void>? loadingResult,
  }) {
    return FaveState(
      faves: faves ?? this.faves,
      loadingResult: loadingResult ?? this.loadingResult,
    );
  }

  @override
  List<Object?> get props => [faves, loadingResult];
}
