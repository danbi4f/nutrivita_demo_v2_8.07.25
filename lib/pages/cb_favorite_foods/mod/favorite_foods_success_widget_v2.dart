import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/mod/favorite_foods_item_v2.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';

class FavoriteFoodsSuccessWidgetV2 extends StatelessWidget {
  const FavoriteFoodsSuccessWidgetV2({super.key, required this.list});

  final List<CompleteFood> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final food = list[index];
        return FavoriteFoodsItemV2(food: food);
      },
    );
  }
}
