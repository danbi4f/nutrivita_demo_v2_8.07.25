import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/widgets/fave_item.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:collection/collection.dart';

class FaveSuccessWidget extends StatelessWidget {
  const FaveSuccessWidget({super.key, required this.listInt, required this.foods});

  final List<int> listInt;
  final List<Food> foods;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: listInt.length,
      itemBuilder: (context, index) {
        final fdcId = listInt[index];
        final food = foods.firstWhereOrNull((food) => food.fdcId == fdcId);
        if (food == null) {
          return ListTile(
            title: Text('Food item with FDC ID $fdcId not found'),
          );
        }
        return FaveItem(fdcId: fdcId, food: food);
      },
    );
  }
}
