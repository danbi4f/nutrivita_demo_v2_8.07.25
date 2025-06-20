import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/foods_bloc.dart';
import '../controllers/foods_event.dart';
import '../controllers/foods_state.dart';
import '../../../data/datasources/food_local_datasource.dart';
import '../../../data/repositories_impl/food_repository_impl.dart';
import '../../../domain/usecases/get_sorted_foods_by_nutrient.dart';

class FoodsListPage extends StatelessWidget {
  const FoodsListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => FoodsBloc(
            GetSortedFoodsByNutrient(FoodRepositoryImpl(FoodLocalDataSource())),
          )..add(LoadFoodsByNutrient('203')),
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
                            (n) => n.nutrient.number == '203',
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
