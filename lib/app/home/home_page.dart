import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutrivita_demo_v2/core/key/app_scaffold_key.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/pages/categories_page.dart';
import 'package:nutrivita_demo_v2/app/home/my_drawer.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/pages/fave_widget.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/pages/food_page.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    LocaleSettings.getLocaleStream().listen((event) {
      print('🍕🍕🍕☠️ locale changed: $event');
    });
    context.read<FaveBloc>().add(LoadFaves());
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _selectTab(int index) {
    if (index == currentIndex) {
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
    final t = Translations.of(context);
    return SafeArea(
      child: Scaffold(
        key: rootScaffoldKey, 
        drawer: MyDrawer(),
        extendBody: true,
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: currentIndex,
          children: [
            _buildNavigator(_navigatorKeys[0], const CategoriesPage()),
            _buildNavigator(_navigatorKeys[1], FoodPage()),
            _buildNavigator(_navigatorKeys[2], const FaveWidget()),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 50),
            decoration: BoxDecoration(
              color: const Color(0xFFD9E5C4),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 25),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
              child: GNav(
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                selectedIndex: currentIndex,
                onTabChange: _selectTab,
                tabs:  [
                  GButton(icon: Icons.category, text: t.home_page.categories),
                  GButton(icon: Icons.restaurant, text: t.home_page.food),
                  GButton(icon: Icons.favorite, text: t.home_page.faves),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
