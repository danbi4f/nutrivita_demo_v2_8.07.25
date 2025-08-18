import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/main_layout/widget/background_animated.dart';
import 'package:nutrivita_demo_v2/main_layout/widget/column_animated.dart';
import 'package:nutrivita_demo_v2/main_layout/widget/drawer_animated.dart';
import 'package:nutrivita_demo_v2/main_layout/widget/main_app_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout>
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
