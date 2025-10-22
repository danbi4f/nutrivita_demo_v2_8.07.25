import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/bloc/complete_food_bloc.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/domain/model/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/pages/cb_fave/presentation/bloc/fave_bloc.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    super.key,
    required this.foodDescription,
  });

  final SurveyFoodsDescription foodDescription;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteFoodBloc(combinedDataService: context.read())
        ..add(LoadCompleteFoodByFdcId(foodDescription.fdcId)),
      child: _SearchItem(
        foodDescription: foodDescription,
        isFavorite: false,
      ),
    );
  }
}

class _SearchItem extends StatefulWidget {
  const _SearchItem({
    required this.foodDescription,
    bool? isFavorite,
  }) : _isFavorite = isFavorite ?? false;

  final SurveyFoodsDescription foodDescription;
  final bool? _isFavorite;

  @override
  State<_SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<_SearchItem> {
  // late final ProductDetailsBloc _bloc;

    @override
  void initState() {
    super.initState();
    // _bloc = context.read();
  }
  
  @override
  Widget build(BuildContext context) {
        final item = context.select(
      (CompleteFoodBloc bloc) => bloc.state.completeFood,
    );

    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewFoodWithNutrients(food: item.value!),
          ),
        );
      },
      child: CustomContainer(
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
                      widget.foodDescription.descriptionPL,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading(context),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.foodDescription.description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(context),
                    ),
                    Text(
                      widget.foodDescription.fdcId.toString(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(context),
                    ),
                  ],
                ),
              ),

              /// Ikona serca
              SizedBox(
                width: 60,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<FaveBloc>()
                          .add(AddFave(widget.foodDescription.fdcId));
                    },
                    icon: Icon(
                      widget._isFavorite! ? Icons.favorite : Icons.favorite_border,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // void _toggleFavourite() => _bloc.add(const ToggleFavorite());
}
