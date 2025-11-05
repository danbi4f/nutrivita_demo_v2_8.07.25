import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/widgets/fave_success_widget.dart';

class FaveWidget extends StatelessWidget {
  const FaveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Fave', style: AppTextStyles.heading(context, size: 40), ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: CustomContainer(
        isGradient: true,
        child: BlocConsumer<FaveBloc, FaveState>(
          listener: (context, state) {
            if (state.loadingResult.error != null) {
              context.read<FaveBloc>().add(const ClearError());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to perform this action')),
              );
            }
          },
          builder: (context, state) {
            final resultInt = state.faves;
            final resultFoods = state.foods;
            print('🚕🚕🚕FaveWidget rebuild with resultInt: ${resultInt.length}');
            print('🚕🚕🚕FaveWidget rebuild with resultFoods: ${resultFoods.length}');
      
            if (resultInt.isEmpty) {
              return Center(
                child: Text(
                  'No favorite products',
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
