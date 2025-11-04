import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/c_fave/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/c_fave/presentation/mod/fave_success_widget.dart';

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
            final result = state.faves;
            print('🚕🚕🚕FaveWidget rebuild with state: ${result.length}');
      
            if (result.isEmpty) {
              return Center(
                child: Text(
                  'No favorite products',
                  style: AppTextStyles.subheading(context),
                ),
              );
            }
      
            return FaveSuccessWidget(list: result);
          },
        ),
      ),
    );
  }
}
