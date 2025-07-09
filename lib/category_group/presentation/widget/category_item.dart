import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/number_nutrient_group_view.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, this.onTap, required this.category});

  final void Function()? onTap;
  final CategoryGroup category;

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<FoodsBloc>(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: NumberNutrientGroupView(category: category),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: onTap ?? _onTap,
      child: Container(
        height: 120,
        width: 200,
        margin: const EdgeInsets.all(10),
        //padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            // dark
            BoxShadow(
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              offset: const Offset(4, 4),
              blurRadius: 20,
              spreadRadius: 5,
            ),

            // light
            BoxShadow(
              color: Colors.white24,
              offset: const Offset(-4, -4),
              blurRadius: 20,
              spreadRadius: -5,
            ),

            //
          ],
        ),
        child: Center(
          child: Text(
            category.categoryName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
