import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberBloc, NumberState>(
      builder: (context, state) {
        if (state is NumberLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NumberLoaded) {
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
                  SelectNumber(
                    numberSelected: selectedNumber.number,
                    numberName: selectedNumber.name,
                  ),
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
        } else if (state is NumberError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}
