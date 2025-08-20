part of 'category_group_bloc.dart';

sealed class CategoryGroupEvent extends Equatable {
  const CategoryGroupEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoryGroupEvent {
  const GetCategoryEvent();

  @override
  List<Object> get props => [];
}
