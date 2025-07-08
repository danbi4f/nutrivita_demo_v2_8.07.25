import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/common/model/delayed_result.dart';

part 'category_group_event.dart';
part 'category_group_state.dart';

class CategoryGroupBloc extends Bloc<CategoryGroupEvent, CategoryGroupState> {
  CategoryGroupBloc(this.categoryGroupRepository)
    : super(CategoryGroupState()) {
    on<CategoryGroupEvent>(_onLoadCategories);
  }

  final CategoryGroupRepository categoryGroupRepository;

  Future<void> _onLoadCategories(
    CategoryGroupEvent event,
    Emitter<CategoryGroupState> emit,
  ) async {
    emit(state.copyWith(delayedResult: DelayedResult.inProgress()));
    try {
      final categories = await categoryGroupRepository.getCategories();
      emit(
        state.copyWith(
          categories: categories,
          delayedResult: DelayedResult.fromValue(
            'Categories loaded successfully',
          ),
        ),
      );
    } on Exception catch (ex) {
      emit(state.copyWith(delayedResult: DelayedResult.fromError(ex)));
    }
  }
}
