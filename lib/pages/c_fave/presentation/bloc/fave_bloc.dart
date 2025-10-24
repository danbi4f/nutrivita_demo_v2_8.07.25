import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:nutrivita_demo_v2/pages/c_fave/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

part 'fave_event.dart';
part 'fave_state.dart';

class FaveBloc extends Bloc<FaveEvent, FaveState> {
  final CombinedDataService combinedDataService;
  late final InMemoryFaveRepository inMemoryFaveRepository;

  FaveBloc({required this.combinedDataService})
    : super(const FaveState(faves: [], loadingResult: DelayedResult.idle())) {
    inMemoryFaveRepository = combinedDataService.inMemoryFaveRepository;

    on<LoadFaves>(_onLoadFaves);
    on<AddFave>(_onAddFave);
    on<RemoveFave>(_onRemoveFave);
    on<ClearError>(_onClearError);
  }

  Future<void> _onLoadFaves(LoadFaves event, Emitter<FaveState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      print('🚕🚕🚕loadingResult: const DelayedResult.inProgress()');
      final List<int> faves = await inMemoryFaveRepository.favesFuture;
      print('🚕🚕🚕faves loaded: $faves');

      emit(
        state.copyWith(faves: faves, loadingResult: const DelayedResult.idle()),
      );

      await emit.onEach(
        inMemoryFaveRepository.favesStream,
        onData: (favesList) {
          print('🚕🚕🚕favesStream updated: $favesList');
          emit(state.copyWith(faves: favesList));
        },
        onError: (error, stackTrace) {
          if (kDebugMode) print('Error in favesStream: $error');
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingResult: DelayedResult.fromError(Exception(e.toString())),
        ),
      );
    }
  }

  Future<void> _onAddFave(AddFave event, Emitter<FaveState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      await inMemoryFaveRepository.addFave(event.fdcId);
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (ex) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(ex)));
    }
  }

  Future<void> _onRemoveFave(RemoveFave event, Emitter<FaveState> emit) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      await inMemoryFaveRepository.removeFave(event.fdcId);
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));
    } on Exception catch (ex) {
      emit(state.copyWith(loadingResult: DelayedResult.fromError(ex)));
    }
  }

  void _onClearError(ClearError event, Emitter emit) {
    emit(state.copyWith(loadingResult: const DelayedResult.idle()));
  }
}
