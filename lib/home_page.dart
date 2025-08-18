import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/category_group/data/repository/category_group_repository.dart';
import 'package:nutrivita_demo_v2/category_group/data/service/category_group_service.dart';
import 'package:nutrivita_demo_v2/category_group/presentation/bloc/category_group_bloc.dart';
import 'package:nutrivita_demo_v2/main_layout/main_layout.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nutrivita_demo_v2/search_engine/data/repository/search_engine_repository.dart';
import 'package:nutrivita_demo_v2/search_engine/data/service/search_engine_asset_service.dart';
import 'package:nutrivita_demo_v2/search_engine/presentation/bloc/search_engine_bloc.dart';
import 'package:nutrivita_demo_v2/search_engine/presentation/widget/search_engine_success_widget.dart';
import 'package:nutrivita_demo_v2/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const MainLayout(),
    SearchEngineSuccessWidget(),
    SettingPage(),
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
              (context) => SearchEngineBloc(
                SearchEngineRepository(SearchEngineAssetService()),
              ),
        ),
      ],
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: GNav(
              backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              color: Colors.black,
              activeColor: Colors.green[700],
              gap: 8,
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: const [
                GButton(icon: Icons.home, text: 'Home', iconSize: 35),
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
    );
  }
}
