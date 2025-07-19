import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/bloc/foods_state.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/widget/ingredient_by_category_item.dart';

class IngredientByCategorySuccessWidget extends StatelessWidget {
  const IngredientByCategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBloc, FoodsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.foods.length,
          itemBuilder: (context, index) {
            final item = state.foods[index];
            final nutrientNumber = state.nutrientNumber;
            return IngredientByCategoryItem(
              item: item,
              nutrientNumber: nutrientNumber,
            );
          },
        );
      },
    );
  }
}
