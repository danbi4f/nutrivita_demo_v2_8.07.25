import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';

class CompleteFoodView extends StatelessWidget {
  const CompleteFoodView({super.key, required this.food});
  final Food food;

  static Widget withBloc(Food food) {
    return BlocProvider(
      create: (context) => IsFaveBloc(
        getFavesStream: context.read<CombinedDataService>().favesStream,
        addToFaveUseCase: context.read<CombinedDataService>().addToFaveUseCase,
        removeFaveUseCase: context.read<CombinedDataService>().removeFaveUseCase,
      ),
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
  final Food food;

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
        final isFave = state.faveIds.contains(widget.food.fdcId);

        return CustomContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.ads_click_rounded, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(child: Container()),
                  IconButton(
                    onPressed: _toggleFavourite,
                    icon: Icon(
                      isFave ? Icons.favorite : Icons.favorite_border,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

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

  void _toggleFavourite() =>
      _bloc.add(ToggleFavorite(widget.food.fdcId));
}
