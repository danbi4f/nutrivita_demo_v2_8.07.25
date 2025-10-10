import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/presentation/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/presentation/mod/favorite_foods_success_widget_v2.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

class FavoriteFoodsWidgetV2 extends StatelessWidget {
  const FavoriteFoodsWidgetV2({super.key});

  static Widget withBloc() {
    return BlocProvider(
      create:
          (context) => FavoriteFoodsV2Bloc(
            repository: context.read<CompleteFoodRepository>(),
          )..add(LoadFavoritesFdcId()),
      child: const FavoriteFoodsWidgetV2(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: BlocBuilder<FavoriteFoodsV2Bloc, FavoriteFoodsV2State>(
        builder: (context, state) {
          final result = state.favorites;

          if (result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.isError) {
            print(result.error);
            return Center(child: Text('error: ${result.error}'));
          } else if (result.isSuccessful) {
            final list = result.valueOrNull ?? [];

            if (list.isEmpty) {
              return Center(
                child: Text(
                  'Brak ulubionych produktów',
                  style: AppTextStyles.subheading(context),
                ),
              );
            }

            return FavoriteFoodsSuccessWidgetV2(list: list);
          } else {
            return Center(
              child: Text(
                'Nothing downloaded yet',
                style: AppTextStyles.subheading(context),
              ),
            );
          }
        },
      ),
    );
  }
}
