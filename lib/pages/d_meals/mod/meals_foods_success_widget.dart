import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/mod/meals_foods_success_item.dart';

class MealsFoodsSuccessWidget extends StatelessWidget {
  const MealsFoodsSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: Column(
        children: [
          BlocBuilder<MealsBloc, MealsState>(
            builder: (context, state) {
              final result = state.meals;

              if (result.isInProgress) {
                return const Center(child: CircularProgressIndicator());
              }

              if (result.isError) {
                return Center(
                  child: Text(
                    'error: ${result.error}',
                    style: AppTextStyles.subheading(context),
                  ),
                );
              }

              if (result.isSuccessful) {
                final list = result.value!;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'No meals yet',
                      style: AppTextStyles.subheading(context),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final meal = list[index];
                      return MealsFoodsSuccessItem(meal: meal);
                    },
                  ),
                );
              }

              return Center(
                child: Text(
                  'Nothing downloaded yet',
                  style: AppTextStyles.subheading(context),
                ),
              );
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/new_recipe');
                  },
                  child: Icon(Icons.add, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
