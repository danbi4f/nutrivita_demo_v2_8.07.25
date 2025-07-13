import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_state.dart';

class IngredientByCategorySuccessWidget extends StatelessWidget {
  const IngredientByCategorySuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBloc, FoodsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.foods.length,
          itemBuilder: (context, index) {
            final item = state.foods[index];
            return Card(
              color: Theme.of(context).colorScheme.surfaceBright,
              margin: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(5),
                ),

                height: 200,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
