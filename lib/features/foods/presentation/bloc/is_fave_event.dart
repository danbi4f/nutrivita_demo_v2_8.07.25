part of 'is_fave_bloc.dart';


abstract class IsFaveEvent extends Equatable {
  const IsFaveEvent();
  @override
  List<Object?> get props => [];
}

class ToggleFavorite extends IsFaveEvent {
  final int fdcId;
  const ToggleFavorite(this.fdcId);

  @override
  List<Object?> get props => [fdcId];
}

class _SyncFavs extends IsFaveEvent {
  final List<int> ids;
  const _SyncFavs(this.ids);
}



// sealed class IsFaveEvent extends Equatable {
//   const IsFaveEvent();

//   @override
//   List<Object?> get props => [];
// }

// final class LoadIsFave extends IsFaveEvent {
//   const LoadIsFave();
// }


// class ToggleFave extends IsFaveEvent {
//   const ToggleFave();
// }

// // 🔹 wewnętrzny event (nieużywany poza blocem)
// class _SyncIsFaveState extends IsFaveEvent {
//   final bool isFave;
//   const _SyncIsFaveState(this.isFave);

//   @override
//   List<Object?> get props => [isFave];
// }

// class SelectFood extends IsFaveEvent {
//   final Food food;
//   const SelectFood(this.food);
// }