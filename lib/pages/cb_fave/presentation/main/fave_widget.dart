import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/presentation/mod/fave_success_widget.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';

class FaveWidget extends StatelessWidget {
  const FaveWidget({super.key});

  // static Widget withBloc() {
  //   return BlocProvider(
  //     create:
  //         (context) => FavoriteFoodsV2Bloc(
  //           combinedDataService: context.read(),
  //         )..add(LoadFavoritesFdcId()),
  //     child: const FavoriteFoodsWidgetV2(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: BlocBuilder<FaveBloc, FaveState>(
        builder: (context, state) {
          final result = state;

          if (result.loadingResult.isInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.loadingResult.isError) {
            print(result.loadingResult.error);
            return Center(child: Text('error: ${result.loadingResult.error}'));
          } else if (result.loadingResult.isSuccessful) {
            final list = result.faves;

            if (list.isEmpty) {
              return Center(
                child: Text(
                  'Brak ulubionych produktów',
                  style: AppTextStyles.subheading(context),
                ),
              );
            }

            return FaveSuccessWidget(list: list);
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
