import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/domain/model/meal.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/complet_foods.dart';

class MealDetailsPage extends StatelessWidget {
  final Meal meal;

  const MealDetailsPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final nutrientTotals = meal.sumAllNutrients();

    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: meal.foods.length,
                itemBuilder: (context, index) {
                  final CompleteFood food = meal.foods[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(
                        food.descriptionPL.isNotEmpty
                            ? food.descriptionPL
                            : food.description,
                      ),
                      subtitle: Text("FDC ID: ${food.fdcId}"),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              "Summary nutrients:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: ListView(
                children:
                    nutrientTotals.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key),
                        trailing: Text(entry.value.toStringAsFixed(2)),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
