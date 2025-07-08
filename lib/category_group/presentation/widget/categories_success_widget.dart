import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_item.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryGroup> categories =
        context.watch<CategoryGroupBloc>().state.categories;

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryItem(
                categoryName: category.categoryName,
                onTap: () {
                  print('Category $index tapped ${category.categoryName}');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
