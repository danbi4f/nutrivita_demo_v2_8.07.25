import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/main/categories_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/select_number/select_number.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/survey_foods/main/cut_survey_by_category_widget.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/repository/search_engine_repository.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/data/service/search_engine_asset_service.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/bloc/search_engine_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_search_engine_page/presentation/widget/search_engine_success_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;
  Widget? selectedPage; // ekran zastępujący IndexedStack

  final List<Widget> pages = [
    const CategoriesPage(),
    SearchEngineSuccessWidget(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => CategoryGroupBloc(
                CategoryGroupRepository(CategoryGroupService()),
              )..add(GetCategoryEvent()),
        ),
        BlocProvider(
          create:
              (_) => SearchEngineBloc(
                SearchEngineRepository(SearchEngineAssetService()),
              ),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          body:
              selectedPage ??
              IndexedStack(index: currentIndex, children: pages),
          bottomNavigationBar: Container(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GNav(
                backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                color: Colors.black, // domyślny kolor
                activeColor: Colors.green[700],
                gap: 8,
                // jeśli jesteśmy w SelectNumber lub CutSurvey, nie zaznaczamy żadnego przycisku
                selectedIndex: selectedPage != null ? -1 : currentIndex,
                onTabChange: (index) {
                  setState(() {
                    currentIndex = index;
                    selectedPage = null; // powrót do głównych ekranów
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.category,
                    text: 'Categories',
                    iconSize: 35,
                  ),
                  GButton(
                    icon: Icons.search_outlined,
                    text: 'Search',
                    iconSize: 35,
                  ),
                  GButton(icon: Icons.favorite, text: 'Favorite', iconSize: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Funkcja otwierająca SelectNumber
  void openSelectNumber(CategoryGroup category) {
    setState(() {
      selectedPage = SelectNumber(
        category: category,
        onSelectNutrient: (nutrientNumber) {
          setState(() {
            // zamiast Navigator.push, pokazujemy CutSurveyByCategoryWidget w body
            selectedPage = CutSurveyByCategoryWidget(
              nutrientNumber: nutrientNumber,
            );
          });
        },
        onBack: () {
          setState(() {
            selectedPage = null;
          });
        },
      );
    });
  }
}
