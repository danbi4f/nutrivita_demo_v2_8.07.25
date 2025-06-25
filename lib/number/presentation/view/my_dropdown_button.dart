import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_event.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberBloc, NumbersState>(
      builder: (context, state) {
        final result = state.delayedResult;
        final isProgress = result.isInProgress;

        if (isProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (result.isSuccessful) {
          return DropdownButtonFormField<Number>(
            value: state.numbers.firstWhere(
              (n) => n.number == state.numberSelected,
              orElse: () => state.numbers.first,
            ),
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

                print(
                  'Selected number: ${selectedNumber.number} (${selectedNumber.name})',
                );
              }
            },
            decoration: const InputDecoration(
              labelText: 'Select Number',
              border: OutlineInputBorder(),
            ),
          );
        } else if (result.isError) {
          return Center(child: Text('Error: ${state.delayedResult.error}'));
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}
