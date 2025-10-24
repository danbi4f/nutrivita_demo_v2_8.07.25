import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/food/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/pages/food/presentation/view/widget/complete_food_view.dart';
import 'package:nutrivita_demo_v2/pages/food/presentation/view/widget/my_text_field.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodBloc>(
      create:
          (context) =>
              FoodBloc(combinedDataService: context.read<CombinedDataService>())
                ..add(FetchFoods()),
      child: const _FoodPage(),
    );
  }
}

class _FoodPage extends StatelessWidget {
  const _FoodPage();

  @override
  Widget build(BuildContext context) {
    final foods = context.select((FoodBloc bloc) => bloc.state.foods);
    final progress =
        context
            .select((FoodBloc bloc) => bloc.state.loadingResult)
            .isInProgress;
    return Scaffold(
      appBar: AppBar(title: const Text('Foods')),
      body: CustomContainer(
        isGradient: true,
        child: Column(
          children: [
            const MyTextField(),
            const SizedBox(height: 16),
            if (progress) const CircularProgressIndicator(),
            if (foods.isEmpty && !progress) const Text('No items found'),
            if (!progress)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return CompleteFoodView.withBloc(food);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
