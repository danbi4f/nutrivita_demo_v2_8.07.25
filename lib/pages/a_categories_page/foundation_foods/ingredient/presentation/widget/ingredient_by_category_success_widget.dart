import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/presentation/bloc/foods_state.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/presentation/widget/ingredient_by_category_item.dart';

class IngredientByCategorySuccessWidget extends StatelessWidget {
  const IngredientByCategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBloc, FoodsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            title: Text(
              'List of Foundation Foods',
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

                  Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer.withOpacity(0.3),
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
              itemCount: state.foods.length,
              itemBuilder: (context, index) {
                final item = state.foods[index];
                final nutrientNumber = state.nutrientNumber;
                return IngredientByCategoryItem(
                  item: item,
                  nutrientNumber: nutrientNumber,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
