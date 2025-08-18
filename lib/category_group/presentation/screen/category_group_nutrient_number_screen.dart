import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/presentation/widget/cut_survey_by_category_widget.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/widget/ingredient_by_category_widget.dart';

class CategoryGroupNutrientNumberScreen extends StatelessWidget {
  const CategoryGroupNutrientNumberScreen({
    super.key,
    required this.category,
    required this.flag,
  });

  final CategoryGroup category;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white.withOpacity(0.5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text(
          category.categoryName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.surfaceBright,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              blurRadius: 20,
            ),
          ],
        ),
        child: ListView.builder(
          itemCount: category.nutrientsGroup.length,
          itemBuilder: (context, index) {
            final nutrientByGroup = category.nutrientsGroup[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            flag
                                ? IngredientByCategoryWidget(
                                  nutrientNumber: nutrientByGroup.number,
                                )
                                : CutSurveyByCategoryWidget(
                                  nutrientNumber: nutrientByGroup.number,
                                ),
                  ),
                );
              },
              child: Card(
                color: Theme.of(context).colorScheme.surfaceBright,
                margin: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    boxShadow: [
                      // dark
                      BoxShadow(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.surfaceContainerLowest,
                        offset: const Offset(7, 7),
                        blurRadius: 25,
                        spreadRadius: 2,
                      ),

                      // light
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        offset: const Offset(-4, -4),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),

                      //
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),

                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        nutrientByGroup.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.surfaceBright,
                        ),
                      ),
                      Text(
                        nutrientByGroup.number,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.surfaceBright,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
