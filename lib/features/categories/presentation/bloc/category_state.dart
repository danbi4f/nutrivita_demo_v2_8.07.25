part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final DelayedResult<List<CategoryNutrient>> result;

  const CategoryState({this.result = const DelayedResult.idle()});

  CategoryState copyWith({DelayedResult<List<CategoryNutrient>>? result}) {
    return CategoryState(result: result ?? this.result);
  }

  @override
  List<Object?> get props => [result];
}
