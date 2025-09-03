import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/arc/b_search_engine_page/data/repository/search_engine_repository.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods.dart';

part 'search_engine_event.dart';
part 'search_engine_state.dart';

class SearchEngineBloc extends Bloc<SearchEngineEvent, SearchEngineState> {
  SearchEngineBloc(this.searchEngineRepository) : super(SearchEngineState()) {
    on<LoadCutSurveyFoodsByName>(_onLoadFoodsByName);
    on<ClearSearchResults>((event, emit) {
      emit(state.copyWith(foods: []));
    });
  }

  final SearchEngineRepository searchEngineRepository;

  Future<void> _onLoadFoodsByName(
    LoadCutSurveyFoodsByName event,
    Emitter<SearchEngineState> emit,
  ) async {
    emit(state.copyWith(delayedResult: const DelayedResult.inProgress()));
    try {
      final List<SurveyFoods> foods = await searchEngineRepository
          .searchFoodsByName(event.searchFoodsByName);
      emit(
        state.copyWith(
          searchFoodsByName: event.searchFoodsByName,
          foods: foods,
          delayedResult: const DelayedResult.fromValue(
            'Load foods by name successfully',
          ),
        ),
      );
      print('Load foods by name successfully');
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}
