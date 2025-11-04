import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/widgets/fave_item.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:collection/collection.dart';

class FaveSuccessWidget extends StatelessWidget {
  const FaveSuccessWidget({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    final foods = context.select((FoodBloc bloc) => bloc.state);
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final fdcId = list[index];
        final food = foods.foods.firstWhereOrNull((f) => f.fdcId == fdcId);
        if (food == null) {
          return ListTile(
            title: Text('Food item with FDC ID $fdcId not found'),
          );
        }
        return FaveItem(fdcId: fdcId, food: food);
      },
    );
  }
}
