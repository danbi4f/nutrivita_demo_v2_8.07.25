import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_state.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';

class MyListView extends StatelessWidget {
  const MyListView({super.key, required this.state});

  final FoodsState state;

  @override
  Widget build(BuildContext context) {
    final selectedNumber =
        context.watch<NumberBloc>().state.numberSelected.number;

    return ListView.builder(
      itemCount: state.foods.length,
      itemBuilder: (context, index) {
        final food = state.foods[index];

        final hasNutrient = food.foodNutrients.any(
          (n) => n.nutrient.number == selectedNumber,
        );

        if (hasNutrient) {
          final ironNutrient = food.foodNutrients.firstWhere(
            (n) => n.nutrient.number == selectedNumber,
          );
          final ironAmount = ironNutrient.amount;
          final ironAmountName = ironNutrient.nutrient.name;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              ),
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
              ],
            ),
            child: ListTile(
              title: Text(food.description),
              subtitle: Text(
                '$ironAmountName: ${ironAmount.toStringAsFixed(2)} mg',
              ),
            ),
          );
        } else {
          return ListTile(
            title: Text(food.description),
            subtitle: const Text('Składnik nie występuje w tym produkcie'),
          );
        }
      },
    );
  }
}
