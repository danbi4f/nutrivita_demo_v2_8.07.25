import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/pages/b_food/presentation/bloc/cubit/is_fave_bloc.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

class CompleteFoodView extends StatelessWidget {
  const CompleteFoodView({super.key, required this.food});
  final CompleteFood food;

  static Widget withBloc(CompleteFood food) {
    return BlocProvider(
      create:
          (context) =>
              IsFaveBloc(context.read<CombinedDataService>(), food: food)
                ..add(LoadIsFave()),
      child: CompleteFoodView(food: food),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewFoodWithNutrients(food: food),
            ),
          );
        },
        child: _CompleteFoodItem(food: food),
      ),
    );
  }
}

class _CompleteFoodItem extends StatefulWidget {
  const _CompleteFoodItem({required this.food});
  final CompleteFood food;

  @override
  State<_CompleteFoodItem> createState() => _CompleteFoodItemState();
}

class _CompleteFoodItemState extends State<_CompleteFoodItem> {
  late final IsFaveBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<IsFaveBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsFaveBloc, IsFaveState>(
      builder: (context, state) {
        return CustomContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.ads_click_rounded, color: Colors.grey),
                const SizedBox(width: 10),

                /// Teksty
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.food.descriptionPL,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subheading(context),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.food.description,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(context),
                      ),
                      Text(
                        widget.food.fdcId.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(context),
                      ),
                    ],
                  ),
                ),

                // Ikona serca
                SizedBox(
                  width: 60,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        _toggleFavourite();
                      },
                      icon: Icon(
                        state.isFave ? Icons.favorite : Icons.favorite_border,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleFavourite() => _bloc.add(const ToggleFave());
}
