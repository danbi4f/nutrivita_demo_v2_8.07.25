import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/main/categories_page_v2.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/presentation/main/search_engine_widget_v2.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/presentation/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/presentation/main/favorite_foods_widget_v2.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/main/meals_foods_success_widget_v2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Widget withBloc() {
    return BlocProvider<FavoriteFoodsV2Bloc>(
      create:
          (context) =>
              FavoriteFoodsV2Bloc(combinedDataService: context.read())
                ..add(LoadFavoritesFdcId()),

      child: const HomePage(),
    );
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _selectTab(int index) {
    if (index == currentIndex) {
      // Jeżeli ponownie klikniemy w aktywną zakładkę → wróć na jej "root"
      _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => currentIndex = index);
    }
  }

  Widget _buildNavigator(GlobalKey<NavigatorState> key, Widget child) {
    return Navigator(
      key: key,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            _buildNavigator(_navigatorKeys[0], const CategoriesPageV2()),
            _buildNavigator(_navigatorKeys[1], SearchEngineWidgetV2.withBloc()),
            _buildNavigator(_navigatorKeys[2], const FavoriteFoodsWidgetV2()),
            _buildNavigator(_navigatorKeys[3], MealsFoodsSuccessWidgetV2()),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GNav(
              gap: 4,
              tabBorderRadius: 16,
              backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              color: Colors.black,
              activeColor: Colors.green[700],
              selectedIndex: currentIndex,
              onTabChange: _selectTab,
              tabs: const [
                GButton(icon: Icons.category, text: 'Categories', iconSize: 25),
                GButton(icon: Icons.restaurant, text: 'Food', iconSize: 25),
                GButton(icon: Icons.favorite, text: 'Favorites', iconSize: 25),
                GButton(icon: Icons.menu_book, text: 'Recipes', iconSize: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   // Funkcja otwierająca SelectNumber
//   // callback openSelectNumber
//   void openSelectNumber(CategoryGroup category) {
//     setState(() {
//       selectedPage = SelectNumber(
//         category: category,
//         onSelectNutrient: (nutrientNumber) {
//           // Znajdź odpowiedni element w liście nutrientsGroup
//           final nutrient = category.nutrientsGroup.firstWhere(
//             (n) => n.number == nutrientNumber,
//           );

//           setState(() {
//             selectedPage = CutSurveyByCategoryWidget(
//               nutrientNumber: nutrient.number,
//               nameRanking: nutrient.name, // <- tu masz teraz dostęp do name
//               onBack: () {
//                 // wracamy do SelectNumber
//                 openSelectNumber(category);
//               },
//             );
//           });
//         },
//         onBack: () {
//           setState(() {
//             selectedPage = null;
//           });
//         },
//       );
//     });
//   }
// }
