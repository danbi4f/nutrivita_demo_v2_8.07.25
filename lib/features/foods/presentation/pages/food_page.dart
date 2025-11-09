import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/widget/complete_food_view.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/widget/my_text_field.dart';
import 'dart:math';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FoodPage();
  }
}

class _FoodPage extends StatelessWidget {
  const _FoodPage();

  final int itemsPerPage = 6;
  final int columns = 2;

  @override
  Widget build(BuildContext context) {
    final foods = context.select((FoodBloc bloc) => bloc.state.foods);
    final progress =
        context.select((FoodBloc bloc) => bloc.state.loadingResult).isInProgress;

    final pages = <List<dynamic>>[];
    for (var i = 0; i < foods.length; i += itemsPerPage) {
      pages.add(foods.sublist(i, min(i + itemsPerPage, foods.length)));
    }

    final pageController = PageController(viewportFraction: 0.92);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Foods', style: AppTextStyles.heading(context, size: 40)),
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
              const Text(
                'No items found',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),

            if (!progress)
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  padEnds: false,
                  itemCount: pages.length,
                  itemBuilder: (context, pageIndex) {
                    final pageItems = pages[pageIndex];

                    return Padding(
                      padding: EdgeInsets.only(
                        left: pageIndex == 0 ? 16 : 8,
                        right: 8,
                      ),
                      child: Center(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: pageItems.length,
                          itemBuilder: (context, index) {
                            final food = pageItems[index];
                            return CompleteFoodView(food: food);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
