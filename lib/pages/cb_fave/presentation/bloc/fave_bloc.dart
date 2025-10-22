import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/data/repository/in_memory_favorite_repository%20.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

part 'fave_event.dart';
part 'fave_state.dart';

class FaveBloc extends Bloc<FaveEvent, FaveState> {
  final CombinedDataService combinedDataService;
  late final InMemoryFavoriteRepository inMemoryFavoriteRepository;

  FaveBloc({required this.combinedDataService})
    : super(const FaveState(faves: [], loadingResult: DelayedResult.idle())) {
    inMemoryFavoriteRepository = combinedDataService.inMemoryFavoriteRepository;

    on<LoadFaves>(_onLoadFavoritesFdcId);
    on<AddFave>(_onAddFavoriteFoodFdcId);
    on<RemoveFave>(_onRemoveFavoriteFoodFdcId);
    
  }

  Future<void> _onLoadFavoritesFdcId(
    LoadFaves event,
    Emitter<FaveState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingResult: const DelayedResult.inProgress()));
      final List<int> faves = await inMemoryFavoriteRepository.favesFuture;

      emit(state.copyWith(faves: faves));
      emit(state.copyWith(loadingResult: const DelayedResult.idle()));

    } catch (e) {
      emit(
        state.copyWith(loadingResult: DelayedResult.fromError(Exception(e.toString()))),
      );
    }
  }

  Future<void> _onAddFavoriteFoodFdcId(
    AddFave event,
    Emitter<FaveState> emit,
  ) async {
    await inMemoryFavoriteRepository.addFave(event.fdcId);
  }

  Future<void> _onRemoveFavoriteFoodFdcId(
    RemoveFave event,
    Emitter<FaveState> emit,
  ) async {
    await inMemoryFavoriteRepository.removeFave(event.fdcId);
  }


}
