import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';
import 'package:nutrivita_demo_v2/config/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/app/home/home_page.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FaveBloc>(
          create:
              (context) => FaveBloc(
                favesFuture: context.read<CombinedDataService>().favesFuture,
                favesStream: context.read<CombinedDataService>().favesStream,
                addFave: context.read<CombinedDataService>().addToFaveUseCase,
                removeFave:
                    context.read<CombinedDataService>().removeFaveUseCase,
                getFoodByFdcId:
                    context.read<CombinedDataService>().getFoodByFdcId,
              )..add(LoadFaves()),
        ),
        BlocProvider(
          create:
              (context) => FoodBloc(
                getAllFoods: context.read<CombinedDataService>().getAllFoods,
                searchFoods:
                    context.read<CombinedDataService>().searchFoodsUseCase,
              )..add(FetchFoods()),
        ),
        BlocProvider(
          create:
              (context) => IsFaveBloc(
                getFavesStream: context.read<CombinedDataService>().favesStream,
                addToFaveUseCase:
                    context.read<CombinedDataService>().addToFaveUseCase,
                removeFaveUseCase:
                    context.read<CombinedDataService>().removeFaveUseCase,
                getFavesFuture: context.read<CombinedDataService>().favesFuture,
              ),
        ),
      ],
      child: MaterialApp(
        theme: simpleTheme2,
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: HomePage()),
      ),
    );
  }
}
