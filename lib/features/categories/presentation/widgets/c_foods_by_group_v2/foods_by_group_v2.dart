import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/c_foods_by_group_v2/foods_by_group_item_v2.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';

class FoodsByGroupV2 extends StatelessWidget {
  const FoodsByGroupV2({super.key, required this.nutrientByGroup});

  final NutrientNumber nutrientByGroup;

  @override
  Widget build(BuildContext context) {
    final foodState = context.select((FoodBloc bloc) => bloc.state);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          nutrientByGroup.nutrientName,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
      ),
      body: CustomContainer(
        isGradient: true,
        child: ListView.builder(
          itemCount: nutrientByGroup.topFoods.length,
          itemBuilder: (context, index) {
            final status = foodState.loadingResult;
            final food = foodState.foods[index];
            final topFoodsByGroup = nutrientByGroup.topFoods[index];
            return FoodsByGroupItemV2(
              topFoodsByGroup: topFoodsByGroup,
              unit: nutrientByGroup.unit,
              food: food,
              status: status,
            );
          },
        ),
      ),
    );
  }
}
