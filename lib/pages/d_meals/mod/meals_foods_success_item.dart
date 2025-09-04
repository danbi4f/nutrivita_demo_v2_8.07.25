import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/mod/meal_details_page.dart';
import 'package:nutrivita_demo_v2/shared/models/meal.dart';

class MealsFoodsSuccessItem extends StatelessWidget {
  const MealsFoodsSuccessItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(meal.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<MealsBloc>().add(RemoveMeal(meal.id!));
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
        ),
        //color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MealDetailsPage(meal: meal)),
          );
        },
        child: CustomContainer(
          child: ListTile(
            title: Text(meal.name, style: AppTextStyles.subheading(context)),
            subtitle: Text(
              "Products: ${meal.foods.length}",
              style: AppTextStyles.body(context),
            ),
            trailing: const Icon(Icons.play_arrow),
          ),
        ),
      ),
    );
  }
}
