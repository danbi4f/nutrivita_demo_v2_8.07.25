import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/home_page.dart';
import 'package:nutrivita_demo_v2/main_layout/main_layout.dart';
import 'package:nutrivita_demo_v2/setting_page.dart';

class DrawerAnimated extends StatelessWidget {
  const DrawerAnimated({super.key, required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = 220;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        double slide = -drawerWidth + (controller.value * drawerWidth);
        return Transform.translate(
          offset: Offset(slide, 0),
          child: Container(
            margin: EdgeInsets.only(top: 2),
            width: drawerWidth,

            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withOpacity(1),
                        Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      width: 4,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant.withOpacity(0.1),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerHeader(
                          child: Text(
                            "Menu",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),

                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SettingPage(),
                              ),
                            );
                          },
                          leading: Icon(Icons.settings, color: Colors.black),
                          title: Text(
                            "Ustawienia",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
