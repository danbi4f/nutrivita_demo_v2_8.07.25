import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/bloc/search_engine_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/widget/my_text_field.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/widget/search_engine_item.dart';

class SearchEngineSuccessWidget extends StatefulWidget {
  const SearchEngineSuccessWidget({super.key});

  @override
  State<SearchEngineSuccessWidget> createState() =>
      _SearchEngineSuccessWidgetState();
}

class _SearchEngineSuccessWidgetState extends State<SearchEngineSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        centerTitle: true,
        title: Text(
          'Search Results',
          style: AppTextStyles.body(context, size: 30),
        ),
      ),
      body: CustomContainer(
        isGradient: true,
        child: Column(
          children: [
            MyTextField(),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
