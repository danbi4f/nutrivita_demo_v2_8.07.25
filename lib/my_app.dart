import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/mod/new_recipe/new_recipe_page.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/repository/meals_repository.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/data/service/meals_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  MealsBloc(MealsRepository(MealsService()))..add(LoadMeals()),
        ),
      ],
      child: MaterialApp(
        routes: {'/new_recipe': (context) => const NewRecipePage()},
        theme: simpleTheme2,
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: HomePage()),
      ),
    );
  }
}
