import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/widget/nutrient_dropdown_button_2.dart';

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
          return NutrientDropdownButton2(state: state);
        } else if (result.isError) {
          return Center(child: Text('Error: ${state.delayedResult.error}'));
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}
