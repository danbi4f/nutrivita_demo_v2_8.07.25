import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_group_item.dart';
import 'package:nutrivita_demo_v2/widget/my_custom_button.dart';

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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyCustomButton(
              nameButton: 'Foundation Foods',
              onTap: () {
                if (!flag) {
                  setState(() {
                    flag = true;
                  });
                }
              },
              selectedIndex: flag,
            ),
            MyCustomButton(
              nameButton: 'Survey Foods',
              onTap: () {
                if (flag) {
                  setState(() {
                    flag = false;
                  });
                }
              },
              selectedIndex: !flag,
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 4 / 3,
            ),
            itemBuilder: (context, index) {
              return CategoryGroupItem(category: categories[index], flag: flag);
            },
          ),
        ),
      ],
    );
  }
}
