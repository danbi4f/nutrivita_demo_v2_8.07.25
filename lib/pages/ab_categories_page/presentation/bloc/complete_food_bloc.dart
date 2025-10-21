import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

part 'complete_food_event.dart';
part 'complete_food_state.dart';

class CompleteFoodBloc
    extends Bloc<CompleteFoodEvent, CompleteFoodState> {
  final CombinedDataService combinedDataService;

  CompleteFoodBloc({required this.combinedDataService})
    : super(const CompleteFoodState()) {
    on<LoadCompleteFoodByFdcId>(_onLoadCompleteFoodByFdcId);
  }

  Future<void> _onLoadCompleteFoodByFdcId(
    LoadCompleteFoodByFdcId event,
    Emitter<CompleteFoodState> emit,
  ) async {
    // emit(state.copyWith(result: const DelayedResult.inProgress()));

    final CompleteFood? completeFood = await combinedDataService
        .appFoodRepository
        .getCompleteFoodByFdcId(event.fdcId);
    if (completeFood != null) {
      emit(state.copyWith(completeFood: DelayedResult.fromValue(completeFood)));
      print('complete food fdcid: ${completeFood.fdcId} -- CompleteFoodBloc - appFoodRepository.getCompleteFoodByFdcId(event.fdcId)');
    } else {
      emit(
        state.copyWith(
          completeFood: DelayedResult.fromError(Exception("Food not found")),
        ),
      );
    }
  }
}