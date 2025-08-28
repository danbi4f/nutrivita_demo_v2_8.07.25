import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';

class FavoriteFoodsSuccessItem extends StatelessWidget {
  const FavoriteFoodsSuccessItem({super.key, required this.food});

  final SurveyFoods food;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(food.fdcId.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<FavoriteFoodsBloc>().add(RemoveFavoriteFood(food.fdcId));
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
      child: CustomContainer(
        child: ListTile(
          title: Row(
            children: [
              Column(
                children: [
                  Text(
                    food.descriptionPL,
                    style: AppTextStyles.subheading(context),
                  ),
                  SizedBox(height: 10),
                  Text(
                    food.description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(context),
                  ),
                ],
              ),
              Spacer(),
              const Icon(Icons.play_arrow),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
