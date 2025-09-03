part of 'category_group_bloc.dart';

class CategoryGroupState extends Equatable {
  const CategoryGroupState({
    this.categories = const [],
    this.delayedResult = const DelayedResult.idle(),
  });

  final DelayedResult<String> delayedResult;
  final List<CategoryGroup> categories;

  CategoryGroupState copyWith({
    DelayedResult<String>? delayedResult,
    List<CategoryGroup>? categories,
  }) {
    return CategoryGroupState(
      categories: categories ?? this.categories,
      delayedResult: delayedResult ?? this.delayedResult,
    );
  }

  @override
  List<Object> get props => [categories, delayedResult];
}
