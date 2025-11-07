import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/widget/complete_food_view.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/widget/my_text_field.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});



  @override
  Widget build(BuildContext context) {
    return  _FoodPage();
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
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300, // maximum width of one cell

                    childAspectRatio:
                        1.5, // can be adjusted for longer descriptions
                  ),

                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods.elementAt(index);

                    return CompleteFoodView(food: food);
                  },
                ),
              ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
