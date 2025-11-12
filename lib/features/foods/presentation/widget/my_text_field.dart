import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/app/di/injection_container.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';



class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  Timer? _debounce;
  final _controller = TextEditingController();
  late final FoodBloc _foodBloc;

  @override
  void initState() {
    super.initState();
    _foodBloc = sl<FoodBloc>(); 
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      final query = value.trim();
      _foodBloc.add(SearchFoods(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: TextField(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w500,
          backgroundColor: Color(0xFFD9E5C4),
        ),
        controller: _controller,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: const Color(0xFFD9E5C4),
          hintText: t.my_text_field.search_text,
          hintStyle: const TextStyle(color: Colors.black, fontSize: 25),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
