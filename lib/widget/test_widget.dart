import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/bloc_en/foods_bloc_en.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/bloc_en/foods_state_en.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //final List<FinalFoodEN> foodsEN = context.read<FoodsBlocEN>().state.foods;
    return BlocBuilder<FoodsBlocEN, FoodsStateEN>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Theme.of(context).colorScheme.tertiary,
              centerTitle: true,
              title: Text(
                'NutriVita',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
            drawer: Drawer(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHigh,
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [DrawerHeader(child: Text('Nutrivita Demo'))],
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            body: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Text('${state.foods.length}'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
