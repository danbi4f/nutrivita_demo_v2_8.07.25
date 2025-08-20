import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/widgets/background_animated.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/category_group/presentation/widgets/column_animated.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/widgets/drawer_animated.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/widgets/main_app_bar.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
    );
  }

  void toggleDrawer() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(toggleDrawer: toggleDrawer),
      body: Stack(
        children: [
          //background
          BackgroundAnimated(
            controller: _controller,
            toggleDrawer: toggleDrawer,
          ),
          // Drawer
          DrawerAnimated(controller: _controller),
          // Column with HeaderTitle and CategoryGroupWidget
          ColumnAnimated(controller: _controller),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
