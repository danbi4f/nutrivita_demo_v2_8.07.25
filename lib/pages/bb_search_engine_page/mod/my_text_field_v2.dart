import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/bloc/search_engine_v2_bloc.dart';

class MyTextFieldV2 extends StatefulWidget {
  const MyTextFieldV2({super.key});

  @override
  State<MyTextFieldV2> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextFieldV2> {
  Timer? _debounce;
  final _controller = TextEditingController();

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      final query = value.trim();
      // jeśli puste, emitujemy pustą listę
      context.read<SearchEngineV2Bloc>().add(SearchFoodsByPhrase(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.green[700],
          hintText: 'Search for foods...',
          hintStyle: const TextStyle(color: Colors.white70),
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
