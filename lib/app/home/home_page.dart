import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/pages/categories_page.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/pages/fave_widget.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/food_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/pages/food_page.dart';
import 'package:nutrivita_demo_v2/app/combined_data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Widget withBloc() {
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
      ],
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
  ];

  void _selectTab(int index) {
    if (index == currentIndex) {
      // If we click on the active tab again → return to its "root"
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
            _buildNavigator(_navigatorKeys[0], const CategoriesPage()),
            _buildNavigator(_navigatorKeys[1], FoodPage()),
            _buildNavigator(_navigatorKeys[2], const FaveWidget()),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFFD9E5C4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GNav(
              gap: 3,
              tabBorderRadius: 16,
              backgroundColor: const Color(0xFFD9E5C4),
              color: Colors.black,
              activeColor: Colors.green[700],
              selectedIndex: currentIndex,
              onTabChange: _selectTab,
              tabs: const [
                GButton(icon: Icons.category, text: 'Categories', iconSize: 25),
                GButton(icon: Icons.restaurant, text: 'Food', iconSize: 25),
                GButton(icon: Icons.favorite, text: 'Favorites', iconSize: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
