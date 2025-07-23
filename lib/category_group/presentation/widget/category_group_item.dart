import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/screen/category_group_nutrient_number_screen.dart';

class CategoryGroupItem extends StatelessWidget {
  const CategoryGroupItem({
    super.key,
    required this.category,
    required this.flag,
  });

  final CategoryGroup category;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => CategoryGroupNutrientNumberScreen(
                category: category,
                flag: flag,
              ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
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
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
