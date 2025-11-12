import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/app/di/injection_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/paged_grid_layout.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/bloc/category_bloc.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/foods_by_group/foods_by_group_item.dart';
import 'package:nutrivita_demo_v2/features/foods/data/models/food_model.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class FoodsByGroup extends StatelessWidget {
  const FoodsByGroup({super.key, required this.nutrientByGroup});

  final NutrientNumber nutrientByGroup;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          nutrientByGroup.nutrientName,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        bloc: sl<CategoryBloc>(),
        builder: (context, state) {
          if (state.result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.result.isError) {
            return Center(child: Text(t.alerts.error));
          }
          return BlocSelector<FoodBloc, FoodState, List<Food>>(
            bloc: sl<FoodBloc>(),
            selector: (state) => state.foods,
            builder: (context, foods) {
              return CustomContainer(
                isGradient: true,
                child: PagedGridLayout(
                  items: nutrientByGroup.topFoods,
                  columns: 2,
                  itemsPerPage: 6,
                  itemBuilder: (item) {
                    final tf = item;
                    final food = foods.firstWhere(
                      (f) => f.fdcId == tf.fdcId,
                      orElse: () => FoodModel(
                        fdcId: 1,
                        description: 'no data',
                        descriptionPL: 'no data',
                        foodClass: 'no data',
                        nutrients: {},
                      ),
                    );
                    return FoodsByGroupItem(
                      topFoodsByGroup: tf,
                      unit: nutrientByGroup.unit,
                      food: food,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
