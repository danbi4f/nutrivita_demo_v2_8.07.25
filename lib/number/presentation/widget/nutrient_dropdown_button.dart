import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_event.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';

class NutrientDropdownButton extends StatelessWidget {
  NutrientDropdownButton({super.key, required this.state});

  final NumbersState state;

  late final value = state.numbers.firstWhere(
    (n) => n.number == state.numberSelected.number,
    orElse: () => state.numbers.first,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: DropdownButtonFormField<Number>(
        value: value,
        items:
            state.numbers.map((number) {
              return DropdownMenuItem<Number>(
                value: number,
                child: Text(number.name),
              );
            }).toList(),
        onChanged: (selectedNumber) {
          if (selectedNumber != null) {
            context.read<NumberBloc>().add(
              SelectNumber(numberSelected: selectedNumber),
            );
            context.read<FoodsBloc>().add(
              LoadFoodsByNutrient(selectedNumber.number),
            );

            print(
              'Selected number: ${selectedNumber.number} (${selectedNumber.name})',
            );
          }
        },
        decoration: const InputDecoration(
          labelText: 'Select Number',
          border: OutlineInputBorder(),
        ),
      ),
    );
    ;
  }
}
