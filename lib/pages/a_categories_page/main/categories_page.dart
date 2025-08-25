import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/main/components/drawer_animated.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'dart:ui';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/category_group_widget.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/main/components/header_title.dart';

// Dołączasz MainAppBar jako część
part 'components/_main_app_bar.dart';
part 'components/_background_animated.dart';
part 'components/_column_animated.dart';

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
      appBar: _MainAppBar(toggleDrawer: toggleDrawer),
      body: Stack(
        children: [
          _BackgroundAnimated(
            controller: _controller,
            toggleDrawer: toggleDrawer,
          ),
          DrawerAnimated(controller: _controller),
          _ColumnAnimated(controller: _controller),
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
