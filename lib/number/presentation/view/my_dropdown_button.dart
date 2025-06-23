import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/number/data/repository/number_repository.dart';
import 'package:nutrivita_demo_v2/number/data/service/asset_number_service.dart';
import 'package:nutrivita_demo_v2/number/presentation/cubit/number_cubit.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              NumberCubit(NumberRepository(AssetNumberService()))
                ..loadNumbers(),
      child: BlocBuilder<NumberCubit, NumberState>(
        builder: (context, state) {
          if (state is NumberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NumberLoaded) {
            return DropdownButtonFormField<String>(
              items:
                  state.numbers
                      .map(
                        (number) => DropdownMenuItem<String>(
                          value: number.number,
                          child: Text(number.name),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                // Handle the selection change
                print('Selected number ID: $value');
              },
              decoration: InputDecoration(labelText: 'Select Number'),
            );
          } else if (state is NumberError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
