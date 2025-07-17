import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/ingredient/data/service/asset_json_service.dart';
import 'package:nutrivita_demo_v2/ingredient/domain/usecases/get_sorted_foods_by_nutrient.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_event.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_state.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/widget/ingredient_by_category_success_widget.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc_en/foods_bloc_en.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc_en/foods_event_en.dart';
import 'package:nutrivita_demo_v2/ingredient/data/repository/app_food_repository_en.dart';
import 'package:nutrivita_demo_v2/ingredient/data/service/asset_json_service_en.dart';

class IngredientByCategoryWidget extends StatelessWidget {
  const IngredientByCategoryWidget({super.key, required this.nutrientNumber});

  final String nutrientNumber;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => FoodsBloc(
                GetSortedFoodsByNutrient(AppFoodRepository(AssetJsonService())),
              )..add(LoadFoodsByNutrient(nutrientNumber)),
        ),
        BlocProvider(
          create:
              (context) => FoodsBlocEN(
                appFoodRepositoryEN: AppFoodRepositoryEN(AssetJsonServiceEN()),
              )..add(LoadFoodsByNutrientEN()),
        ),
      ],
      child: BlocBuilder<FoodsBloc, FoodsState>(
        builder: (context, state) {
          final result = state.delayedResult;

          if (result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.isSuccessful) {
            return IngredientByCategorySuccessWidget();
          } else if (result.isError) {
            return Center(child: Text('Error: //${state.delayedResult.error}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
