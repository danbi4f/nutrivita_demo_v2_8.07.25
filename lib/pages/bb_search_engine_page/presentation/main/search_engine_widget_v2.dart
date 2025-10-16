import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/bloc/search_engine_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/mod/my_text_field_v2.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/mod/search_engine_success_widget_v2.dart';

class SearchEngineWidgetV2 extends StatelessWidget {
  const SearchEngineWidgetV2({super.key});

  static Widget withBloc() {
    return BlocProvider(
      create:
          (context) => SearchEngineV2Bloc(combinedDataService: context.read()),
      child: const SearchEngineWidgetV2(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _SearchEngineViewV2();
  }
}

class _SearchEngineViewV2 extends StatefulWidget {
  const _SearchEngineViewV2();

  @override
  State<_SearchEngineViewV2> createState() => _SearchEngineV2ViewState();
}

class _SearchEngineV2ViewState extends State<_SearchEngineViewV2> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: Column(
        children: [
          // 🔎 Pole wyszukiwania
          MyTextFieldV2(),

          // 📊 Wyniki wyszukiwania
          Expanded(
            child: BlocBuilder<SearchEngineV2Bloc, SearchEngineV2State>(
              builder: (context, state) {
                if (state is SearchEngineV2LoadInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchEngineV2LoadSuccess) {
                  final results = state.result.value ?? [];
                  return SearchEngineSuccessWidgetV2(results: results);
                } else if (state is SearchEngineV2LoadFailure) {
                  return Center(
                    child: Text(
                      "Błąd: ${state.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return Center(
                  child: Text(
                    "Type something to start searching.",
                    style: AppTextStyles.body(context),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
