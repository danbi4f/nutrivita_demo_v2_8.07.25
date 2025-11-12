import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/widgets/fave_success_widget.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class FaveWidget extends StatelessWidget {
  const FaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.app_bar.app_faves,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomContainer(
        isGradient: true,
        child: BlocConsumer<FaveBloc, FaveState>(
          listener: (context, state) {
            if (state.loadingResult.error != null) {
              context.read<FaveBloc>().add(const ClearError());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(t.alerts.action_failed)));
            }
          },
          builder: (context, state) {
            final resultInt = state.faves;
            final resultFoods = state.foods;
            if (resultInt.isEmpty) {
              return Center(
                child: Text(
                  t.alerts.no_data,
                  style: AppTextStyles.subheading(context),
                ),
              );
            }

            return FaveSuccessWidget(listInt: resultInt, foods: resultFoods);
          },
        ),
      ),
    );
  }
}
