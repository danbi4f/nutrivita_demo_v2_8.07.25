import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_state.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/widget/my_list_view.dart';

class FoodsListPage extends StatefulWidget {
  const FoodsListPage({super.key});

  @override
  State<FoodsListPage> createState() => _FoodsListPageState();
}

class _FoodsListPageState extends State<FoodsListPage> {
  @override
  Widget build(BuildContext context) {
    // final selectedNumber =
    //     context.watch<NumberBloc>().state.numberSelected.number;

    return Column(
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     setState(() {
        //       context.read<FoodsBloc>().add(
        //         LoadFoodsByNutrient(selectedNumber),
        //       );
        //     });
        //   },
        //   child: const Text('Refresh Foods List'),
        // ),
        const SizedBox(height: 16),
        // Container(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Center(
        //     child: Text(
        //       'test - selected number: $selectedNumber',
        //       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        BlocBuilder<FoodsBloc, FoodsState>(
          builder: (context, state) {
            final result = state.delayedResult;

            if (result.isInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (result.isSuccessful) {
              return MyListView();
            } else if (result.isError) {
              return Center(child: Text('Error: ${state.delayedResult.error}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ],
    );
  }
}
