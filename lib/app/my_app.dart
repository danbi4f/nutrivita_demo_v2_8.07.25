import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/app/di/injection_container.dart';
import 'package:nutrivita_demo_v2/config/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/app/home/home_page.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key,});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FaveBloc>(
          create: (_) => sl<FaveBloc>()..add(LoadFaves()),
        ),
        BlocProvider<FoodBloc>(
          create:
              (context) => sl<FoodBloc>()..add(FetchFoods()),
        ),
        BlocProvider<IsFaveBloc>(
          create:
              (context) => sl<IsFaveBloc>(),
        ),
      ],
      child: MaterialApp(
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: [...GlobalMaterialLocalizations.delegates],
        theme: simpleTheme2,
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: HomePage()),
      ),
    );
  }
}
