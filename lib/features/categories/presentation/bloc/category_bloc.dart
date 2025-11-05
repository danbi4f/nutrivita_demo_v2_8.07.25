import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/core/error/failures.dart';
import 'package:nutrivita_demo_v2/core/usecases/usecase.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/usecases/get_all_categories.dart';

part 'category_event.dart';
part 'category_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategories getAllCategories;


  CategoryBloc({required this.getAllCategories, })
    : super(const CategoryState(result: DelayedResult.idle())) {
    on<LoadCategory>(_onLoadCategory);

  }

  Future<void> _onLoadCategory(
    LoadCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(result: const DelayedResult.inProgress()));
    final failureOrData = await getAllCategories(NoParams());

    failureOrData.fold(
      (failure) => emit(
        state.copyWith(
          result: DelayedResult.fromError(
            Exception(_mapFailureToMessage(failure)),
          ),
        ),
      ),
      (data) => emit(state.copyWith(result: DelayedResult.fromValue(data))),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure _:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }


}
