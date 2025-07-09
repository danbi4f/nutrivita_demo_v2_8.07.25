import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_item.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryGroup> categories =
        context.watch<CategoryGroupBloc>().state.categories;
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 4 / 3,
      ),
      itemBuilder: (context, index) {
        return CategoryItem(category: categories[index]);
      },
    );
  }
}
