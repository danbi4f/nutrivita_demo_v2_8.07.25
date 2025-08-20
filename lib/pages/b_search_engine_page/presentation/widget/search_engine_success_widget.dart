import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/bloc/search_engine_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/widget/search_engine_item.dart';

class SearchEngineSuccessWidget extends StatefulWidget {
  const SearchEngineSuccessWidget({super.key});

  @override
  State<SearchEngineSuccessWidget> createState() =>
      _SearchEngineSuccessWidgetState();
}

class _SearchEngineSuccessWidgetState extends State<SearchEngineSuccessWidget> {
  Timer? _debounce;
  final _controller = TextEditingController();

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      final query = value.trim();
      if (query.isEmpty) {
        context.read<SearchEngineBloc>().add(ClearSearchResults());
      } else {
        print('Szukam: $query');
        context.read<SearchEngineBloc>().add(LoadCutSurveyFoodsByName(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        centerTitle: true,
        title: Text(
          'Search Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Theme.of(context).colorScheme.surfaceBright,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green[700],
                hintText: 'Search for foods...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),

                    Theme.of(
                      context,
                    ).colorScheme.onPrimaryContainer.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withOpacity(0.1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: BlocBuilder<SearchEngineBloc, SearchEngineState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.foods.length,
                    itemBuilder: (context, index) {
                      final item = state.foods[index];
                      return SearchEngineItem(item: item);
                    },
                  );
                },
              ),
            ),
          ),
        ],
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
