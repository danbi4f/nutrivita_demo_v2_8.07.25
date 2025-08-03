import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/home_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await ConvertToCutSurveyJson().convertSurveyFoods();
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: simpleTheme2,
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomePage()),
    );
  }
}
