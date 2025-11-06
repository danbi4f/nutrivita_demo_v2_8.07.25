import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/add_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/get_faves_stream.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/is_fave.dart';
import 'package:nutrivita_demo_v2/features/faves/domain/usecases/remove_fave.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

part 'is_fave_state.dart';
part 'is_fave_event.dart';


class IsFaveBloc extends Bloc<IsFaveEvent, IsFaveState> {
  final GetFavesStream getFavesStream;
  final AddToFaveUseCase addToFaveUseCase;
  final RemoveFaveUseCase removeFaveUseCase;

  StreamSubscription<Either<Failure, List<int>>>? _sub;

  IsFaveBloc({
    required this.getFavesStream,
    required this.addToFaveUseCase,
    required this.removeFaveUseCase,
  }) : super(const IsFaveState(faveIds: [])) {
    on<_SyncFavs>(_onSyncFavs);
    on<ToggleFavorite>(_onToggle);

    _sub = getFavesStream(NoParams()).listen((either) {
      either.fold((_) {}, (list) => add(_SyncFavs(list)));
    });
  }

  void _onSyncFavs(_SyncFavs event, Emitter<IsFaveState> emit) {
    emit(state.copyWith(faveIds: event.ids));
  }

  Future<void> _onToggle(ToggleFavorite event, Emitter<IsFaveState> emit) async {
    final isFave = state.faveIds.contains(event.fdcId);

    if (isFave) {
      await removeFaveUseCase(IdParams(fdcId: event.fdcId));
    } else {
      await addToFaveUseCase(IdParams(fdcId: event.fdcId));
    }
    // nie emitujesz nic – stream sam zsynchronizuje
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}







// class IsFaveBloc extends Bloc<IsFaveEvent, IsFaveState> {
//   final GetFavesStream getFavesStream;
//   final IsFave isFave;
//   final AddToFaveUseCase addToFaveUseCase;
//   final RemoveFaveUseCase removeFaveUseCase;

//   StreamSubscription<Either<Failure, List<int>>>? _faveSub;
//   IsFaveBloc({
//     required this.getFavesStream,
//     required this.isFave,
//     required this.addToFaveUseCase,
//     required this.removeFaveUseCase,
//   }) : super(
//          IsFaveState(
//            food: null,
//            isFave: false,
//            checkoutResult: DelayedResult.idle(),
//          ),
//        ) {
//     on<LoadIsFave>(_onloadIsFave);
//     on<ToggleFave>(_ontoggleFavorite);
//     on<_SyncIsFaveState>(_onSyncIsFaveState);
//     on<SelectFood>(_onSelectFood);

//     // 🔹 Subscribe to changes to your favorites list
//     _faveSub = getFavesStream(NoParams()).listen((either) {
//       either.fold(
//         (_) {}, // fail możesz zalogować jeśli chcesz
//         (faves) {
//           final id = state.food?.fdcId;
//           if (id == null) return;
//           final isNowFave = faves.contains(id);
//           add(_SyncIsFaveState(isNowFave));
//         },
//       );
//     });

//     add(const LoadIsFave()); // first check
//   }

//   Future<void> _onloadIsFave(
//     LoadIsFave event,
//     Emitter<IsFaveState> emit,
//   ) async {
//     final id = state.food?.fdcId;
//     if (id == null) return;
//     final check = await isFave(IdParams(fdcId: id));
//     check.fold((_) {}, (value) => emit(state.copyWith(isFave: value)));
//   }

//   Future<void> _ontoggleFavorite(
//     ToggleFave event,
//     Emitter<IsFaveState> emit,
//   ) async {
//     final id = state.food?.fdcId;
//     if (id == null) return;
//     final isFave = state.isFave;

//     emit(state.copyWith(isFave: !isFave));

//     if (isFave) {
//       await removeFaveUseCase(IdParams(fdcId: id));
//     } else {
//       await addToFaveUseCase(IdParams(fdcId: id));
//     }
//   }

//   void _onSelectFood(SelectFood event, Emitter<IsFaveState> emit) {
//     emit(state.copyWith(food: event.food));
//     add(const LoadIsFave());
//   }

//   // 🔹 New event to synchronize
//   void _onSyncIsFaveState(_SyncIsFaveState event, Emitter<IsFaveState> emit) {
//     emit(state.copyWith(isFave: event.isFave));
//   }

//   @override
//   Future<void> close() {
//     _faveSub?.cancel();
//     return super.close();
//   }
// }
