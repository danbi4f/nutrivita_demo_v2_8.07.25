import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/b_food/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_food/presentation/view/widget/complete_food_view.dart';
import 'package:nutrivita_demo_v2/pages/b_food/presentation/view/widget/my_text_field.dart';
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
                child: GridView.builder(
                  //padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        300, // maksymalna szerokość jednej komórki
                    // mainAxisSpacing: 12,
                    // crossAxisSpacing: 12,
                    childAspectRatio:
                        1.5, // można dostosować dla dłuższych opisów
                  ),
        
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return CompleteFoodView.withBloc(food);
                  },
                  // shrinkWrap: true,
                  // physics: BouncingScrollPhysics(),
                ),
              ),
              SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
