import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

part 'is_fave_state.dart';
part 'is_fave_event.dart';

class IsFaveBloc extends Bloc<IsFaveEvent, IsFaveState> {
  final CombinedDataService _combinedDataService;
  StreamSubscription<List<int>>? _faveSub;
  IsFaveBloc(this._combinedDataService, {required CompleteFood food})
    : super(
        IsFaveState(
          food: food,
          isFave: false,
          checkoutResult: DelayedResult.idle(),
        ),
      ) {
    on<LoadIsFave>(_onloadIsFave);
    on<ToggleFave>(_ontoggleFavorite);
    on<_SyncIsFaveState>(_onSyncIsFaveState);

    // 🔹 Subskrypcja zmian w liście ulubionych
    _faveSub = _combinedDataService.inMemoryFaveRepository.favesStream.listen(
      (faves) {
        final isNowFave = faves.contains(food.fdcId);
        add(_SyncIsFaveState(isNowFave)); // wewnętrzny event, patrz niżej
      },
      onError: (error) {
        debugPrint('❌ Błąd streamu ulubionych: $error');
      },
    );

    add(const LoadIsFave()); // pierwsze sprawdzenie
  }

  Future<void> _onloadIsFave(
    LoadIsFave event,
    Emitter<IsFaveState> emit,
  ) async {
    final isFave = await _combinedDataService.inMemoryFaveRepository.isFave(
      state.food.fdcId,
    );
    emit(state.copyWith(isFave: isFave));
  }

  Future<void> _ontoggleFavorite(
    ToggleFave event,
    Emitter<IsFaveState> emit,
  ) async {
    final isFave = state.isFave;
    emit(state.copyWith(isFave: !isFave));
    if (isFave) {
      await _combinedDataService.inMemoryFaveRepository.removeFave(
        state.food.fdcId,
      );
    } else {
      await _combinedDataService.inMemoryFaveRepository.addFave(
        state.food.fdcId,
      );
    }
  }

  // 🔹 Nowy event do synchronizacji
  void _onSyncIsFaveState(_SyncIsFaveState event, Emitter<IsFaveState> emit) {
    emit(state.copyWith(isFave: event.isFave));
  }

  @override
  Future<void> close() {
    _faveSub?.cancel();
    return super.close();
  }
}
