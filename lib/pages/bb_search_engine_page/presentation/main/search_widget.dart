import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/bloc/search_bloc.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/mod/my_text_field.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/mod/search_success_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  static Widget withBloc() {
    return BlocProvider<SearchBloc>(
      create:
          (context) => SearchBloc(combinedDataService: context.read()),
      child: const SearchWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _SearchWidget();
  }
}

class _SearchWidget extends StatefulWidget {
  const _SearchWidget();

  @override
  State<_SearchWidget> createState() => _SearchState();
}

class _SearchState extends State<_SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: Column(
        children: [
          // 🔎 Pole wyszukiwania
          MyTextField(),

          // 📊 Wyniki wyszukiwania
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.loadingResult.isInProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.loadingResult.isSuccessful) {
                  final results = state.result;
                  return SearchSuccessWidget(results: results);
                } else if (state.loadingResult.isError) {
                  return Center(
                    child: Text(
                      "Błąd: ${state.loadingResult.error}",
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
