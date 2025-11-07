import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/bloc/category_bloc.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/foods_by_group/foods_by_group_item.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';

class FoodsByGroup extends StatelessWidget {
  const FoodsByGroup({super.key, required this.nutrientByGroup});

  final NutrientNumber nutrientByGroup;

  @override
  Widget build(BuildContext context) {
    final foodState = context.select((FoodBloc bloc) => bloc.state);

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
        builder: (context, state) {
          if (state.result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.result.isError) {
            return const Center(child: Text("Error loading food"));
          }

          return CustomContainer(
            isGradient: true,
            child: ListView.builder(
              itemCount: nutrientByGroup.topFoods.length,
              itemBuilder: (context, index) {
                final topFoodsByGroup = nutrientByGroup.topFoods[index];
                final fdcId = nutrientByGroup.topFoods[index].fdcId;
                final food = foodState.foods.firstWhere(
                  (f) => f.fdcId == fdcId,
                );

                return FoodsByGroupItem(
                  topFoodsByGroup: topFoodsByGroup,
                  unit: nutrientByGroup.unit,
                  food: food,
                );
              },
            ),
          );
        },
      ),
    );
  }
}