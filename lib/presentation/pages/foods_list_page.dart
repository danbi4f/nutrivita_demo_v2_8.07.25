import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/foods_bloc.dart';
import '../bloc/foods_event.dart';
import '../bloc/foods_state.dart';
import '../../data/service/asset_json_service.dart';
import '../../data/repository/app_food_repository.dart';
import '../../../domain/usecases/get_sorted_foods_by_nutrient.dart';

class FoodsListPage extends StatelessWidget {
  const FoodsListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => FoodsBloc(
            GetSortedFoodsByNutrient(AppFoodRepository(AssetJsonService())),
          )..add(LoadFoodsByNutrient('303')),
      child: Scaffold(
        appBar: AppBar(title: const Text('Foods sorted by Iron (Fe)')),
        body: BlocBuilder<FoodsBloc, FoodsState>(
          builder: (context, state) {
            if (state is FoodsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FoodsLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.foods.length,
                itemBuilder: (context, index) {
                  final food = state.foods[index];

                  final ironAmount =
                      food.foodNutrients
                          .firstWhere(
                            (n) => n.nutrient.number == '303',
                            orElse: () => food.foodNutrients.first,
                          )
                          .amount;
                  return Card(
                    child: ListTile(
                      title: Text(food.description),
                      subtitle: Text(
                        'Iron (Fe): ${ironAmount.toStringAsFixed(2)} mg',
                      ),
                    ),
                  );
                },
              );
            } else if (state is FoodsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}
