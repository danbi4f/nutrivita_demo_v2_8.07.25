import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create:
        //       (_) => FoodsBloc(
        //         GetSortedFoodsByNutrient(AppFoodRepository(AssetJsonService())),
        //       ),
        // ),
        BlocProvider(
          create:
              (_) => CategoryGroupBloc(
                CategoryGroupRepository(CategoryGroupService()),
              )..add(GetCategoryEvent()),
        ),
      ],
      child: MainLayout(),
    );
  }
}
