import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_future.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';

part 'is_fave_state.dart';
part 'is_fave_event.dart';

class IsFaveBloc extends Bloc<IsFaveEvent, IsFaveState> {
  final GetFavesStream getFavesStream;
  final AddToFaveUseCase addToFaveUseCase;
  final RemoveFaveUseCase removeFaveUseCase;
  final GetFavesFuture getFavesFuture;

  StreamSubscription<Either<Failure, List<int>>>? _sub;

  IsFaveBloc({
    required this.getFavesStream,
    required this.addToFaveUseCase,
    required this.removeFaveUseCase,
    required this.getFavesFuture,
  }) : super(const IsFaveState(faveIds: [])) {
    on<_SyncFavs>(_onSyncFavs);
    on<ToggleFavorite>(_onToggle);

    _sub = getFavesStream(NoParams()).listen((either) {
      either.fold((_) {}, (list) => add(_SyncFavs(list)));
    });

    _loadInitial();
  }

  Future<void> _loadInitial() async {
    final either = await getFavesFuture(NoParams());
    either.fold((_) {}, (list) => add(_SyncFavs(list)));
  }

  void _onSyncFavs(_SyncFavs event, Emitter<IsFaveState> emit) {
    emit(state.copyWith(faveIds: event.ids));
  }

  Future<void> _onToggle(
    ToggleFavorite event,
    Emitter<IsFaveState> emit,
  ) async {
    final isFave = state.faveIds.contains(event.fdcId);

    if (isFave) {
      await removeFaveUseCase(IdParams(fdcId: event.fdcId));
    } else {
      await addToFaveUseCase(IdParams(fdcId: event.fdcId));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}

