// import 'package:flutter/material.dart';
// import 'package:nutrivita_demo_v2/home_page.dart';

// void main() {
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: Text('Nutrivita Demo v2'), centerTitle: true),
//         body: HomePage(),
//       ),
//     );
//   }
// }

// main.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrivita_demo_v2/models/food_data_root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodsListScreen(),
    );
  }
}

class FoodsListScreen extends StatefulWidget {
  const FoodsListScreen({Key? key}) : super(key: key);

  @override
  State<FoodsListScreen> createState() => _FoodsListScreenState();
}

class _FoodsListScreenState extends State<FoodsListScreen> {
  List<FoundationFood> foods = [];
  final targetNutrientNumber = '303'; // Iron

  @override
  void initState() {
    super.initState();
    loadAndSortFoods();
  }

  Future<void> loadAndSortFoods() async {
    final jsonStr = await rootBundle.loadString(
      'assets/FoodData_Central_foundation_food_json_2025-04-24.json',
    );
    final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
    final dataRoot = FoodDataRoot.fromJson(jsonMap);

    dataRoot.foundationFoods.sort((a, b) {
      final aAmount = _getNutrientAmount(a, targetNutrientNumber);
      final bAmount = _getNutrientAmount(b, targetNutrientNumber);
      return bAmount.compareTo(aAmount); // sort malejąco
    });

    setState(() {
      foods = dataRoot.foundationFoods;
    });
  }

  double _getNutrientAmount(FoundationFood food, String number) {
    return food.foodNutrients
        .firstWhere(
          (n) => n.nutrient.number == number,
          orElse:
              () => FoodNutrient(
                amount: 0.0,
                nutrient: Nutrient(number: number, name: '', unitName: ''),
              ),
        )
        .amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foods sorted by Iron (Fe)')),
      body:
          foods.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: foods.length,
                itemBuilder: (context, index) {
                  final food = foods[index];
                  final ironAmount = _getNutrientAmount(
                    food,
                    targetNutrientNumber,
                  );

                  return Card(
                    child: ListTile(
                      title: Text(food.description),
                      subtitle: Text(
                        'Iron (Fe): ${ironAmount.toStringAsFixed(2)} mg',
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
