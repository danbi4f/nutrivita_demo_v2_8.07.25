import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CombinedDataService combinedDataService;

  CategoryBloc({required this.combinedDataService})
    : super(const CategoryState()) {
    on<LoadCategory>(_onLoadCategory);
  }

  Future<void> _onLoadCategory(
    LoadCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(result: const DelayedResult.inProgress()));
    final List<CategoryNutrient> categories =
        await combinedDataService.categoryRepository.getAllCategories();

    final result = DelayedResult.fromValue(categories);

    emit(state.copyWith(result: result));
  }
}
