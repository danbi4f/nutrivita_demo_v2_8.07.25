import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/pages/c_favorite_foods/mod/favorite_foods_success_item.dart';

class FavoriteFoodsSuccessWidget extends StatelessWidget {
  const FavoriteFoodsSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: BlocBuilder<FavoriteFoodsBloc, FavoriteFoodsState>(
        builder: (context, state) {
          final result = state.favorites;

          if (result.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.isError) {
            print(result.error);
            return Center(
              child: Text(
                'error: ${result.error}',
                style: AppTextStyles.subheading(context),
              ),
            );
          }

          if (result.isSuccessful) {
            final list = result.value!;
            if (list.isEmpty) {
              return Center(
                child: Text(
                  'No favorites yet',
                  style: AppTextStyles.subheading(context),
                ),
              );
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final food = list[index];
                return FavoriteFoodsSuccessItem(food: food);
              },
            );
          }

          return Center(
            child: Text(
              'Nothing downloaded yet',
              style: AppTextStyles.subheading(context),
            ),
          );
        },
      ),
    );
  }
}
