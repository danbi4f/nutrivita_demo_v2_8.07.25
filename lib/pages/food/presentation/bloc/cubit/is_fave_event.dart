part of 'is_fave_bloc.dart';


sealed class IsFaveEvent extends Equatable {
  const IsFaveEvent();

  @override
  List<Object?> get props => [];
}

final class LoadIsFave extends IsFaveEvent {
  const LoadIsFave();
}


class ToggleFave extends IsFaveEvent {
  const ToggleFave();
}

// 🔹 wewnętrzny event (nieużywany poza blocem)
class _SyncIsFaveState extends IsFaveEvent {
  final bool isFave;
  const _SyncIsFaveState(this.isFave);

  @override
  List<Object?> get props => [isFave];
}