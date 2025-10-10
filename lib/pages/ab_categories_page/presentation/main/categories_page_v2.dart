import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/main/components/drawer_animated_v2.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/main/components/header_title_v2.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/mod/category_group_v2/category_group_widget_v2.dart';

part 'components/_main_app_bar_v2.dart';
part 'components/_background_animated_v2.dart';
part 'components/_column_animated_v2.dart';

class CategoriesPageV2 extends StatefulWidget {
  const CategoriesPageV2({super.key});

  @override
  State<CategoriesPageV2> createState() => _CategoriesPageV2State();
}

class _CategoriesPageV2State extends State<CategoriesPageV2>
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
      appBar: _MainAppBarV2(toggleDrawer: toggleDrawer),
      body: Stack(
        children: [
          _BackgroundAnimatedV2(
            controller: _controller,
            toggleDrawer: toggleDrawer,
          ),
          DrawerAnimatedV2(controller: _controller),
          _ColumnAnimatedV2(controller: _controller),
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
