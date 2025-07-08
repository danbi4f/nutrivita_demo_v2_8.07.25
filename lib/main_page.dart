import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/data/repository/app_food_repository.dart';
import 'package:nutrivita_demo_v2/ingredient/data/service/asset_json_service.dart';
import 'package:nutrivita_demo_v2/ingredient/domain/usecases/get_sorted_foods_by_nutrient.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/bloc/foods_bloc.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/pages/foods_list_page.dart';
import 'package:nutrivita_demo_v2/number/data/repository/number_repository.dart';
import 'package:nutrivita_demo_v2/number/data/service/asset_number_service.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_bloc.dart';
import 'package:nutrivita_demo_v2/number/presentation/Bloc/number_event.dart';
import 'package:nutrivita_demo_v2/number/presentation/view/my_dropdown_button.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/categories_success_widget.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/widget/category_item.dart';
import 'package:nutrivita_demo_v2/widget/container_body.dart';
import 'package:nutrivita_demo_v2/widget/header_title.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [DrawerHeader(child: Text('Nutrivita Demo'))],
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
          body: BlocListener<NumberBloc, NumbersState>(
            listener: (context, state) {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(),
                const SizedBox(height: 40.0),
                ContainerBody(
                  children: [
                    CategoriesSuccessWidget(),
                    //MyDropdownButton(),
                    //FoodsListPage(),
                    Text('data', textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
