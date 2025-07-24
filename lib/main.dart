import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/simple_theme.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/service/convert_to_cut_survey_json.dart';
import 'package:nutrivita_demo_v2/home_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await ConvertToCutSurveyJson().convertSurveyFoods();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: simpleTheme,
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomePage()),
    );
  }
}
