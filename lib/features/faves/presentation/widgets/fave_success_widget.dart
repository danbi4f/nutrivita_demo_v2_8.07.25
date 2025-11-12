import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/food_grid_item.dart';
import 'package:nutrivita_demo_v2/common/widgets/paged_grid_layout.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:collection/collection.dart';

class FaveSuccessWidget extends StatelessWidget {
  const FaveSuccessWidget({
    super.key,
    required this.listInt,
    required this.foods,
    this.itemsPerPage = 6,
  });

  final List<int> listInt;
  final List<Food> foods;
  final int itemsPerPage;

  @override
  Widget build(BuildContext context) {
    // we map fdcId → Food (we skip not found)
    final faveFoods =
        listInt
            .map(
              (fdcId) => foods.firstWhereOrNull((food) => food.fdcId == fdcId),
            )
            .whereType<Food>()
            .toList();

    return SafeArea(
      bottom: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return PagedGridLayout<Food>(
            items: faveFoods,
            itemsPerPage: 6,
            columns: 2,
            viewportFraction: 0.91,
            dynamicAvailableHeight: constraints.maxHeight,
            itemBuilder: (food) => FoodGridItem(food: food, isFaveItem: true),
          );
        },
      ),
    );
  }
}
