import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/food_grid_item.dart';
import 'package:nutrivita_demo_v2/common/widgets/paged_grid_layout.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/widget/my_text_field.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FoodPage();
  }
}

class _FoodPage extends StatelessWidget {
  const _FoodPage();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        final foods = state.foods;
        final progress = state.loadingResult.isInProgress;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              t.app_bar.app_food,
              style: AppTextStyles.heading(context, size: 40),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: CustomContainer(
            isGradient: true,
            child: Column(
              children: [
                const MyTextField(),
                if (progress) const CircularProgressIndicator(),
                if (foods.isEmpty && !progress)
                  Text(
                    t.alerts.no_data,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                if (!progress)
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final totalHeight = MediaQuery.of(context).size.height;
                        final padding = MediaQuery.of(context).padding;
                        final appBarHeight = kToolbarHeight;

                        final gridHeight =
                            totalHeight -
                            padding.top -
                            padding.bottom -
                            appBarHeight;

                        return PagedGridLayout<Food>(
                          items: foods,
                          itemsPerPage: 6,
                          columns: 2,
                          dynamicAvailableHeight: gridHeight,
                          itemBuilder: (food) => FoodGridItem(food: food),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
