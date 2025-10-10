import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/presentation/bloc/meals_bloc.dart';
import 'package:nutrivita_demo_v2/pages/d_meals/domain/model/meal.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';

class NewRecipePage extends StatefulWidget {
  const NewRecipePage({super.key});

  @override
  State<NewRecipePage> createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final List<CompleteFood> _selectedFoods = [];

  void _toggleFoodSelection(CompleteFood food) {
    setState(() {
      if (_selectedFoods.contains(food)) {
        _selectedFoods.remove(food);
      } else {
        _selectedFoods.add(food);
      }
    });
  }

  void _saveMeal(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final meal = Meal(
        name: _nameController.text.trim(),
        foods:
            _selectedFoods, // ⚠️ zakładam, że Meal.foods przyjmie CompleteFood
      );
      context.read<MealsBloc>().add(AddMeal(meal));
      Navigator.pop(context); // wróć po zapisaniu
    }
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ W prawdziwej apce tutaj podciągniesz produkty z DB przez Bloc/Repo
    final dummyFoods = [
      CompleteFood(
        fdcId: 1,
        description: "Apple",
        descriptionPL: "Jabłko",
        foodClass: "Fruit",
        nutrients: {},
      ),
      CompleteFood(
        fdcId: 2,
        description: "Chicken breast",
        descriptionPL: "Pierś z kurczaka",
        foodClass: "Meat",
        nutrients: {},
      ),
      CompleteFood(
        fdcId: 3,
        description: "Rice",
        descriptionPL: "Ryż",
        foodClass: "Grain",
        nutrients: {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new meal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveMeal(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // nazwa posiłku
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Meal name",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Enter meal name"
                            : null,
              ),
              const SizedBox(height: 20),

              // lista produktów
              Expanded(
                child: ListView.builder(
                  itemCount: dummyFoods.length,
                  itemBuilder: (context, index) {
                    final food = dummyFoods[index];
                    final isSelected = _selectedFoods.contains(food);

                    return ListTile(
                      title: Text(food.descriptionPL),
                      subtitle: Text(food.foodClass),
                      trailing:
                          isSelected
                              ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                              : const Icon(Icons.add_circle_outline),
                      onTap: () => _toggleFoodSelection(food),
                    );
                  },
                ),
              ),

              // podsumowanie wybranych
              if (_selectedFoods.isNotEmpty) ...[
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selected foods:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children:
                      _selectedFoods
                          .map((f) => Chip(label: Text(f.descriptionPL)))
                          .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
