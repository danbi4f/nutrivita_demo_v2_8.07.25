import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: simpleTheme2,
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomePage.withBloc()),
    );
  }
}
