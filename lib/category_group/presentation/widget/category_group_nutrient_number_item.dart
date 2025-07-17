import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/widget/ingredient_by_category_widget.dart';

class CategoryGroupNutrientNumberItem extends StatelessWidget {
  const CategoryGroupNutrientNumberItem({super.key, required this.category});

  final CategoryGroup category;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: category.nutrientsGroup.length,
      itemBuilder: (context, index) {
        final item = category.nutrientsGroup[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => Scaffold(
                      appBar: AppBar(),
                      body: IngredientByCategoryWidget(
                        nutrientNumber: item.number,
                      ),
                    ),
              ),
            );
          },
          child: Card(
            color: Theme.of(context).colorScheme.surfaceBright,
            margin: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(5),
              ),

              height: 80,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    item.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  Text(
                    item.number,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
