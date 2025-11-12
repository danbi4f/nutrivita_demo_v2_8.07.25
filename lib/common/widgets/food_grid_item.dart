import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/app/di/injection_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';



class FoodGridItem extends StatelessWidget {
  final Food food;
  final bool isFaveItem;

  const FoodGridItem({super.key, required this.food, this.isFaveItem = false});

  @override
  Widget build(BuildContext context) {
    String short =
        food.description.length > 20
            ? '${food.description.substring(0, 20)}…'
            : food.description;

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ViewFoodWithNutrients(food: food),
            ),
          );
        },
        child: CustomContainer(
          child: MyColumn(isFaveItem: isFaveItem, food: food, short: short),
        ),
      ),
    );
  }
}

class MyColumn extends StatelessWidget {
  const MyColumn({
    super.key,
    required this.isFaveItem,
    required this.food,
    required this.short,
  });

  final bool isFaveItem;
  final Food food;
  final String short;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.ads_click_rounded, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Expanded(child: Container()),
            if (isFaveItem)
              DeleteFaveButton(food: food)
            else
              FaveButton(food: food),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            food.description,
            textAlign: TextAlign.center,
            textScaler: TextScaler.noScaling,
            softWrap: true,
            maxLines: 2,
            style: AppTextStyles.body(context, isBold: true),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class DeleteFaveButton extends StatelessWidget {
  const DeleteFaveButton({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final faveBloc = sl<FaveBloc>();
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () {
        faveBloc.add(RemoveFave(food.fdcId));
      },
    );
  }
}

class FaveButton extends StatelessWidget {
  const FaveButton({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final isFaveBloc = sl<IsFaveBloc>();

    return BlocBuilder<IsFaveBloc, IsFaveState>(
      bloc: isFaveBloc,
      builder: (context, state) {
        final isFave = state.faveIds.contains(food.fdcId);
        return IconButton(
          onPressed: () {
            isFaveBloc.add(ToggleFavorite(food.fdcId));
          },
          icon: Icon(
            isFave ? Icons.favorite : Icons.favorite_border,
            color: Colors.red.shade200,
            size: 30,
          ),
        );
      },
    );
  }
}

class TestColumn extends StatelessWidget {
  const TestColumn({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.abc_outlined)),
        Container(
          height: 40,
          width: 40,
          color: Colors.blue,
          child: Text(food.description),
        ),
      ],
    );
  }
}
