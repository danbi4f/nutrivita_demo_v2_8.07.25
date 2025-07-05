import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_event.dart';
import 'package:nutrivita_demo_v2/number/data/model/number.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';

class NutrientDropdownButton2 extends StatelessWidget {
  const NutrientDropdownButton2({super.key, required this.state});

  final NumbersState state;

  @override
  Widget build(BuildContext context) {
    final numbers = state.numbers;

    // Zabezpieczenie przed pustą listą
    if (numbers.isEmpty) {
      return const Center(child: Text('Brak składników'));
    }

    // Znajdujemy aktualnie zaznaczoną wartość (jeśli istnieje)
    final value = numbers.firstWhere(
      (n) => n.number == state.numberSelected.number,
      orElse: () => numbers.first,
    );

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<Number>(
          isExpanded: true,
          hint: const Text(
            'Wybierz składnik',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
          value: value,
          items:
              numbers.map((number) {
                return DropdownMenuItem<Number>(
                  value: number,
                  child: Text(
                    '${number.number} (${number.name})',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
            }
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 350,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black26),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.yellow),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 14),
          ),
        ),
      ),
    );
  }
}
