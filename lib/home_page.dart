import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/ingredient/data/service/asset_json_service.dart';
import 'package:nutrivita_demo_v2/ingredient/domain/usecases/get_sorted_foods_by_nutrient.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/main_layout.dart';
import 'package:nutrivita_demo_v2/number/data/repository/number_repository.dart';
import 'package:nutrivita_demo_v2/number/data/service/asset_number_service.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => NumberBloc(
                numberRepository: NumberRepository(AssetNumberService()),
              )..add(GetNumbersEvent()),
        ),
        BlocProvider(
          create:
              (_) => FoodsBloc(
                GetSortedFoodsByNutrient(AppFoodRepository(AssetJsonService())),
              ),
        ),
        BlocProvider(
          create:
              (_) => CategoryGroupBloc(
                CategoryGroupRepository(CategoryGroupService()),
              )..add(GetCategoryEvent()),
        ),
      ],
      child: MainPayout(),
    );
  }
}
