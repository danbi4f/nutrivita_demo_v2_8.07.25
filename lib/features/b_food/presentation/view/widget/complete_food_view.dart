import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/features/b_food/presentation/bloc/cubit/is_fave_bloc.dart';
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
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewFoodWithNutrients(food: food),
          ),
        );
      },
      child: _CompleteFoodItem(food: food),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left icon
                  const Icon(Icons.ads_click_rounded, color: Colors.grey),
                  const SizedBox(width: 10),

                  // Spacer to push heart to the right
                  Expanded(child: Container()),

                  // Heart icon
                  IconButton(
                    onPressed: _toggleFavourite,
                    icon: Icon(
                      state.isFave ? Icons.favorite : Icons.favorite_border,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Text description with wrapping
              Expanded(
                child: Text(
                  widget.food.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  style: AppTextStyles.body(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavourite() => _bloc.add(const ToggleFave());
}
