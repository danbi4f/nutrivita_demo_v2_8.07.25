import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/mod/category_group_item.dart';

class CategoryGroupSuccessWidget extends StatefulWidget {
  const CategoryGroupSuccessWidget({super.key});

  @override
  State<CategoryGroupSuccessWidget> createState() =>
      _CategoryGroupSuccessWidgetState();
}

class _CategoryGroupSuccessWidgetState
    extends State<CategoryGroupSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    final List<CategoryGroup> categories =
        context.watch<CategoryGroupBloc>().state.categories;

    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 2 / 1,
            ),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return CategoryGroupItem(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
