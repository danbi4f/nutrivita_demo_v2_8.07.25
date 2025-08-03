import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_group_item.dart';
import 'package:nutrivita_demo_v2/widget/my_custom_button_2.dart';

class CategoryGroupSuccessWidget extends StatefulWidget {
  const CategoryGroupSuccessWidget({super.key});

  @override
  State<CategoryGroupSuccessWidget> createState() =>
      _CategoryGroupSuccessWidgetState();
}

class _CategoryGroupSuccessWidgetState
    extends State<CategoryGroupSuccessWidget> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    final List<CategoryGroup> categories =
        context.watch<CategoryGroupBloc>().state.categories;

    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        children: [
          MyCustomButton2(
            surveyFoodsSelected: flag,
            onToggle: (value) {
              if (flag != value) {
                setState(() {
                  flag = value;
                });
              }
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 2 / 1.45,
              ),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return CategoryGroupItem(
                  category: categories[index],
                  flag: flag,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
