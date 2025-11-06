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



// class IsFaveState extends Equatable {
//   const IsFaveState({
//     required this.food,
//     required this.isFave,
//     required this.checkoutResult,
//   });

//   final Food? food;
//   final bool isFave;
//   final DelayedResult<bool> checkoutResult;

//   IsFaveState copyWith({
//     Food? food,
//     bool? isFave,
//     DelayedResult<bool>? checkoutResult,
//   }) {
//     return IsFaveState(
//       food: food ?? this.food,
//       isFave: isFave ?? this.isFave,
//       checkoutResult: checkoutResult ?? this.checkoutResult,
//     );
//   }

//   @override
//   List<Object> get props => [food?.fdcId ?? -1, isFave, checkoutResult];
// }
