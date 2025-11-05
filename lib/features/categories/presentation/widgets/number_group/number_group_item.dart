import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/nutrient_number.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/bloc/category_bloc.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/foods_by_group/foods_by_group.dart';

class NumberGroupItem extends StatelessWidget {
  final NutrientNumber nutrientByGroup;

  const NumberGroupItem({super.key, required this.nutrientByGroup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => BlocProvider.value(value: context.read<CategoryBloc>(),
                  child: FoodsByGroup(nutrientByGroup: nutrientByGroup),
                ),
          ),
        );
      },
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              nutrientByGroup.nutrientName,
              style: AppTextStyles.subheading(context),
              textAlign: TextAlign.center,
              softWrap: true, // wrap long names
            ),
            const SizedBox(height: 6),
            Text(
              'test1: ${nutrientByGroup.nutrientNumber}',
              style: AppTextStyles.subheading(context),
            ),
          ],
        ),
      ),
    );
  }
}
