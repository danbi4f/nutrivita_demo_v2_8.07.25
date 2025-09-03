import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/select_number/main/select_number.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/survey_foods/main/cut_survey_by_category_widget.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/main/categories_page_v2.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/main/search_engine_widget_v2.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/main/favorite_foods_widget_v2.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/mod/meals_foods_success_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;
  Widget? selectedPage; // ekran zastępujący IndexedStack

  final List<Widget> pages = [
    const CategoriesPageV2(),
    SearchEngineWidgetV2(),
    FavoriteFoodsWidgetV2(),
    MealsFoodsSuccessWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            selectedPage ?? IndexedStack(index: currentIndex, children: pages),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GNav(
              gap: 4,
              tabBorderRadius: 16,
              backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              color: Colors.black, // domyślny kolor
              activeColor: Colors.green[700],
              //gap: 1,
              // jeśli jesteśmy w SelectNumber lub CutSurvey, nie zaznaczamy żadnego przycisku
              selectedIndex: selectedPage != null ? -1 : currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                  selectedPage = null; // powrót do głównych ekranów
                });
              },
              tabs: const [
                GButton(icon: Icons.category, text: 'Categories', iconSize: 25),
                GButton(
                  icon: Icons.search_outlined,
                  text: 'Search',
                  iconSize: 25,
                ),
                GButton(icon: Icons.favorite, text: 'Favorites', iconSize: 25),
                GButton(icon: Icons.menu_book, text: 'Recipes', iconSize: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Funkcja otwierająca SelectNumber
  // callback openSelectNumber
  void openSelectNumber(CategoryGroup category) {
    setState(() {
      selectedPage = SelectNumber(
        category: category,
        onSelectNutrient: (nutrientNumber) {
          // Znajdź odpowiedni element w liście nutrientsGroup
          final nutrient = category.nutrientsGroup.firstWhere(
            (n) => n.number == nutrientNumber,
          );

          setState(() {
            selectedPage = CutSurveyByCategoryWidget(
              nutrientNumber: nutrient.number,
              nameRanking: nutrient.name, // <- tu masz teraz dostęp do name
              onBack: () {
                // wracamy do SelectNumber
                openSelectNumber(category);
              },
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
