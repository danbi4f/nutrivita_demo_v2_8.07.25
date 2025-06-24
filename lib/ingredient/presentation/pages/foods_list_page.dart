import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import '../bloc/foods_bloc.dart';
import '../bloc/foods_event.dart';
import '../bloc/foods_state.dart';
import '../../data/service/asset_json_service.dart';
import '../../data/repository/app_food_repository.dart';
import '../../domain/usecases/get_sorted_foods_by_nutrient.dart';

class FoodsListPage extends StatelessWidget {
  const FoodsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberBloc, NumberState>(
      builder: (context, numberState) {
        if (numberState is NumberLoaded) {
          final selectedNumber = numberState.numberSelected;
          final selectedNumberName = numberState.numberName;

          return BlocProvider(
            create:
                (_) => FoodsBloc(
                  GetSortedFoodsByNutrient(
                    AppFoodRepository(AssetJsonService()),
                  ),
                )..add(LoadFoodsByNutrient(selectedNumber)),
            child: Scaffold(
              appBar: AppBar(title: Text('Foods sorted $selectedNumberName')),
              body: BlocBuilder<FoodsBloc, FoodsState>(
                builder: (context, foodsState) {
                  if (foodsState is FoodsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (foodsState is FoodsLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: foodsState.foods.length,
                      itemBuilder: (context, index) {
                        final food = foodsState.foods[index];
                        final ironAmount =
                            food.foodNutrients
                                .firstWhere(
                                  (n) => n.nutrient.number == selectedNumber,
                                  orElse: () => food.foodNutrients.first,
                                )
                                .amount;
                        return Card(
                          child: ListTile(
                            title: Text(food.description),
                            subtitle: Text(
                              '$selectedNumberName: ${ironAmount.toStringAsFixed(2)} mg',
                            ),
                          ),
                        );
                      },
                    );
                  } else if (foodsState is FoodsError) {
                    return Center(child: Text('Error: ${foodsState.message}'));
                  }
                  return const Center(child: Text('No data'));
                },
              ),
            ),
          );
        }

        // Jeśli NumberBloc nie załadował jeszcze danych:
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
