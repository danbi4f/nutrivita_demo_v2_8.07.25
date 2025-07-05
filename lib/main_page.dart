import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              (_) =>
                  NumberBloc(NumberRepository(AssetNumberService()))
                    ..add(GetNumbersEvent()),
        ),
        BlocProvider(
          create:
              (_) => FoodsBloc(
                GetSortedFoodsByNutrient(AppFoodRepository(AssetJsonService())),
              ),
        ),
      ],
      child: Scaffold(
        body: BlocListener<NumberBloc, NumbersState>(
          listener: (context, state) {},
          child: Column(
            children: const [
              MyDropdownButton(),
              Expanded(child: FoodsListPage()),
            ],
          ),
        ),
      ),
    );
  }
}
