import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/ingredient/presentation/pages/foods_list_page.dart';
import 'package:nutrivita_demo_v2/number/presentation/view/my_dropdown_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          MyDropdownButton(),
          SizedBox(height: 50),
          Expanded(child: FoodsListPage()),
        ],
      ),
    );
  }
}
