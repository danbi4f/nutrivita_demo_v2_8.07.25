import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/bloc/category_bloc.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/category_group/category_group_Success_widget.dart';
import 'package:nutrivita_demo_v2/core/utils/delayed_result.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class CategoryGroupWidget extends StatelessWidget {
  const CategoryGroupWidget({super.key});

  static Widget withBloc() {
    return BlocProvider(
      create:
          (context) => CategoryBloc(
            getAllCategories:
                context.read<CombinedDataService>().getAllCategories,
          )..add(LoadCategory()),
      child: const CategoryGroupWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final result = state.result;

        if (result.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (result.isError) {
          return Center(
            child: Text(
              '${t.alerts.error}: ${result.error}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        } else if (result.isSuccessful) {
          final categories = result.valueOrNull ?? [];
          return CategoryGroupSuccessWidget(categories: categories);
        } else {
          return Center(child: Text(t.alerts.no_data));
        }
      },
    );
  }
}
